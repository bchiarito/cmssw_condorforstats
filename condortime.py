import re
import sys
from datetime import datetime

HEADER = re.compile(r"^\d{3} \(.*?\) (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})")

def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "log.txt"
    first = last = None
    with open(path) as f:
        for line in f:
            m = HEADER.match(line)
            if m:
                ts = datetime.strptime(m.group(1), "%Y-%m-%d %H:%M:%S")
                if first is None:
                    first = ts
                last = ts

    if first is None:
        sys.exit("no timestamped blocks found")
    print(last - first)

if __name__ == "__main__":
    main()
