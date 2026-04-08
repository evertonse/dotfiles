import re
import sys
from collections import defaultdict


def extract_convars_block(text):
    match = re.search(r"Convars\s*\{", text, re.IGNORECASE)
    if not match:
        return None

    i = match.end()
    depth = 1
    start = i

    while i < len(text) and depth > 0:
        if text[i] == "{":
            depth += 1
        elif text[i] == "}":
            depth -= 1
        i += 1

    return text[start : i - 1]


def parse_convars(block):
    import re

    def strip_comments(text):
        result = []
        i = 0
        in_string = False

        while i < len(text):
            if text[i] == '"':
                in_string = not in_string
                result.append(text[i])
                i += 1
            elif not in_string and text[i:i+2] == "//":
                # skip until end of line
                while i < len(text) and text[i] != '\n':
                    i += 1
            else:
                result.append(text[i])
                i += 1

        return ''.join(result)

    block = strip_comments(block)

    # Tokenizer
    token_pattern = re.compile(r'"[^"]*"|\{|\}|[^\s\{\}"]+')
    tokens = token_pattern.findall(block)

    i = 0
    result = {}

    def strip_quotes(s):
        if s.startswith('"') and s.endswith('"'):
            return s[1:-1]
        return s

    def parse_object():
        nonlocal i
        obj = {}

        while i < len(tokens):
            if tokens[i] == '}':
                i += 1
                break

            key = strip_quotes(tokens[i])
            i += 1

            if i >= len(tokens):
                break

            if tokens[i] == '{':
                i += 1
                obj[key] = parse_object()
            else:
                value = strip_quotes(tokens[i])
                i += 1
                obj[key] = value

        return obj

    # Parsing
    while i < len(tokens):
        if tokens[i] == '}':
            i += 1
            continue

        key = strip_quotes(tokens[i])
        i += 1

        if i >= len(tokens):
            break

        if tokens[i] == '{':
            i += 1
            result[key] = parse_object()
        else:
            value = strip_quotes(tokens[i])
            i += 1
            result[key] = value

    return result


def group_by_prefix(convars):
    groups = defaultdict(dict)
    for original_key, value in convars.items():
        key = original_key.strip().lower()

        # Done before but making sure
        if value == "true":
            value = '1'
        elif value == "false":
            value = '0'

        if any(name in key for name in ["parallel", "thread"]):
            prefix = "Multithreading"
        if any(name in key for name in ["pred", "predict", "prediction"]):
            prefix = "Prediction"
        elif any(name in key for name in ["phys", "physics"]):
            prefix = "Physics"
        elif any(name in key for name in ["clock", "network", "usercmd", "sockets", "updaterate", "cmdrate"]) or key.startswith("rate"):
            prefix = "Network"
        elif "particle" in key:
            prefix = "Particles"
        elif any(name in key for name in ["lod", "cull"]) or key.startswith("rate"):
            prefix = "LOD"

        elif any(name in key for name in ["anim", "skel", "bone"]) or key.startswith("ik_"):
            prefix = "Animation"
        elif "_" in key:
            key_words = key.split("_", 1)
            prefix = key_words[0]
            if prefix in {}:
                if len(key_words) <= 1:
                    pass
                else:
                    prefix = key_words[1]
        else:
            prefix = "No Prefix"

        groups[prefix][original_key] = value

    return groups


def pretty_print(groups, filename="all.cvars"):
    with open(filename, "w", encoding="utf-8") as f:
        for prefix in sorted(groups):
            f.write(f"\n// === {prefix.upper()} === //\n\n")

            group = groups[prefix]
            max_key = max(len(k) for k in group)

            justify = False
            for key in sorted(group):
                if justify:
                    f.write(f"{key.ljust(max_key)} {group[key]}\n")
                else:
                    f.write(f"{key} {group[key]}\n")


def convars_from_path(path) -> dict:
    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        text = f.read()

    block = extract_convars_block(text)
    if not block:
        print("Convars block not found")
        return

    convars = parse_convars(block)
    return convars


def main():
    convars = dict()
    files = ['old', 'spooky', 'kai2', 'boot', 'kaiboot']
    # files = ['kai2', 'boot']
    for idx, file in enumerate(files):
        current_name = '+'.join(files[:idx])
        theirs = convars_from_path(file + '.gi')

        for key, value in theirs.items():
            if value == 'true':
                value = '1'
            if value == 'false':
                value = '0'

            if (key in convars) and (convars[key] != value):
                answer = None
                while answer is None or answer == '':
                    answer = str(input(f"Mismatch\n{current_name}[{key}] = {convars[key]}\n{file}[{key}] = {value}\nType value: "))
                    if answer == ''
                    try:
                        if '.' in answer:
                            answer = str(float(answer))
                        else:
                            answer = str(int(answer))

                    except:
                        print(f"Answer must be a number, we got {answer}")
                        answer = None


                print(f'Chose {answer}\n')

                convars[key] = str(answer)
            else:
                convars[key] = value


    groups = group_by_prefix(convars)
    pretty_print(groups)


if __name__ == "__main__":
    main()
