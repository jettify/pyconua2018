import asyncio
import aiorwlock

async def go():
    rwlock = aiorwlock.RWLock()

    async with rwlock.writer:
        print("inside writer: only one writer is possible")

    async with rwlock.reader:
        print("inside reader: multiple reader possible")

loop = asyncio.get_event_loop()
loop.run_until_complete(go())
