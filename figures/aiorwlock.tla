----------------------------- MODULE aiorwlock -----------------------------
EXTENDS Naturals, Sequences, Integers, FiniteSets
CONSTANTS Task
ASSUME /\ Task # {}

VARIABLES State,
          Lock

-----------------------------------------------------------------------------
TypeOK == /\ Lock \in [Task ->
                       {"Read", "Write", "WriteRead", "Waiting", "Finished"}]
          /\ State >= -1
LockInit == Lock = [t \in Task |-> "Waiting"] /\ State = 0
-----------------------------------------------------------------------------
RLocked == State > 0
WLocked == State < 0
Unlocked == State = 0
OwnWrite(t) == Lock[t] \in {"Write"}

RAquire(t) == \/ /\  ~WLocked
                 /\ Lock' = [Lock EXCEPT ![t] = "Read"]
                 /\ State' = State + 1
                 /\ Lock[t] \in {"Waiting"}
              \/ /\ OwnWrite(t)
                 /\ Lock' = [Lock EXCEPT ![t] = "WriteRead"]
                 /\ State' = State + 1

WAquire(t) == /\ Unlocked
              /\ Lock' = [Lock EXCEPT ![t] = "Write"]
              /\ State' = State - 1
              /\ Lock[t] \in {"Waiting"}


RRelease(t) == \/ /\ RLocked /\ Lock[t] = "Read"
                  /\ State' = State - 1
                  /\ Lock' = [Lock EXCEPT ![t] = "Finished"]
               \/ /\ RLocked /\ Lock[t] = "WriteRead"
                  /\ State' = State - 1
                  /\ Lock' = [Lock EXCEPT ![t] = "Write"]

WRelease(t) == \/ /\ WLocked /\ Lock[t] = "Write"
                  /\ State' = State - 1
                  /\ Lock' = [Lock EXCEPT ![t] = "Finished"]
               \/ /\ WLocked /\ Lock[t] = "WriteRead"
                  /\ State' = State - 1
                  /\ Lock' = [Lock EXCEPT ![t] = "Read"]
-----------------------------------------------------------------------------
Next == \E t \in Task: RAquire(t) \/ WAquire(t) \/ RRelease(t) \/ WRelease(t)
Spec == LockInit /\ [][Next]_<<State, Lock>>
LockInv ==
    \A t1 \in Task : \A t2 \in (Task \ {t1}): ~
        (/\ Lock[t1] \in {"Write", "WriteRead"}
         /\ Lock[t2] \in {"Read", "Write", "WriteRead"})
-----------------------------------------------------------------------------
THEOREM Spec => [](TypeOK /\ LockInv)
=============================================================================
