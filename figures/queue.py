import threading

class BoundedQueue:
    def __init__(self, capacity=3):
        self.capacity = capacity
        self.buffer = [None] * capacity
        self.mutex = threading.Lock()
        self.condition = threading.Condition(self.mutex)
        self.size = 0
        self.head = 0
        self.tail = 0

    def is_full(self):
        return self.size == self.capacity

    def is_empty(self):
        return self.size == 0

    def _next(self, x):
        return (x + 1) % self.capacity

    def put(self, item):
        with self.condition:
            while self.is_full():
                self.condition.wait()
            self.buffer[self.tail] = item
            self.tail = self._next(self.tail)
            self.size += 1
            self.condition.notify()

    def get(self):
        with self.condition:
            while self.is_empty():
                self.condition.wait()
            item = self.buffer[self.head]
            self.buffer[self.head] = None
            self.head = self._next(self.head)
            self.size -= 1
            self.condition.notify()
            return item
