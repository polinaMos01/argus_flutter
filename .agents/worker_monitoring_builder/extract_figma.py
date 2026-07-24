import json

def find_node(node, node_id):
    if not isinstance(node, dict):
        return None
    if node.get("id") == node_id:
        return node
    for key, value in node.items():
        if isinstance(value, dict):
            res = find_node(value, node_id)
            if res:
                return res
        elif isinstance(value, list):
            for item in value:
                res = find_node(item, node_id)
                if res:
                    return res
    return None

def print_node_summary(node, f, depth=0):
    if not isinstance(node, dict):
        return
    indent = "  " * depth
    node_type = node.get("type", "UNKNOWN")
    name = node.get("name", "")
    node_id = node.get("id", "")
    f.write(f"{indent}- {node_type} [{node_id}]: {name}\n")
    
    # Print characters for TEXT nodes
    if node_type == "TEXT":
        f.write(f"{indent}  Text: {node.get('characters', '')}\n")
    
    # Print color/fills
    fills = node.get("fills", [])
    if fills:
        for fill in fills:
            if fill.get("type") == "SOLID" and "color" in fill:
                c = fill["color"]
                f.write(f"{indent}  Color: R={c.get('r')}, G={c.get('g')}, B={c.get('b')}, A={c.get('a')}\n")

    children = node.get("children", [])
    for child in children:
        print_node_summary(child, f, depth + 1)

def main():
    try:
        with open("/Users/polinapogosyan/.gemini/antigravity/scratch/figma_full.json", "r") as f:
            data = json.load(f)
        
        target_ids = ["115:1855", "115:2132", "115:2265"]
        with open("figma_details.txt", "w") as out:
            for tid in target_ids:
                out.write("="*80 + "\n")
                out.write(f"SEARCHING FOR NODE: {tid}\n")
                node = find_node(data, tid)
                if node:
                    print_node_summary(node, out)
                else:
                    out.write("NOT FOUND\n")
    except Exception as e:
        with open("error.txt", "w") as err:
            err.write(str(e))

if __name__ == "__main__":
    main()
