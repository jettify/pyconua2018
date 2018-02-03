class _RWLockCore:
    def __init__(self, fast, loop):
        self._state = 0  # positive is shared count, negative exclusive count
        self._owning = []  # tasks will be few, so a list is not inefficient

    @property
    def read_locked(self):
        return self._state > 0
    @property
    def write_locked(self):
        return self._state < 0

    async def acquire_read(self):
        if not self._write_waiters and self._state >= 0:
            self._state += 1
            self._owning.append(me)
            return True
        # ...

    async def acquire_write(self):
        if self._state == 0:
            self._state -= 1
            self._owning.append(me)
            return True
        # ...
