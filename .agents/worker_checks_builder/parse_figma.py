import json

FIGMA_PATH = '/Users/polinapogosyan/.gemini/antigravity/scratch/figma_full.json'
OUTPUT_PATH = '/Users/polinapogosyan/.gemini/antigravity/scratch/argus_flutter/.agents/worker_checks_builder/figma_dump.txt'

with open(FIGMA_PATH, 'r') as f:
    data = json.load(f)

target_ids = [
    '91:2225', '91:2361', '91:2130', # Email Check
    '93:2503', '93:2556', '93:2655', # Phone Check
    '109:1368', '109:1540', '109:1409', '109:1283' # File Check
]

def find_nodes(node, ids):
    results = {}
    
    def recurse(n):
        node_id = n.get('id')
        if node_id in ids:
            results[node_id] = n
        
        children = n.get('children', [])
        for child in children:
            recurse(child)
            
    recurse(node)
    return results

nodes = find_nodes(data, target_ids)

def format_node_summary(node, indent=0):
    lines = []
    prefix = "  " * indent
    node_type = node.get('type')
    node_name = node.get('name')
    node_id = node.get('id')
    
    line = f"{prefix}- [{node_type}] {node_name} ({node_id})"
    
    # Bounding box
    bbox = node.get('absoluteBoundingBox')
    if bbox:
        line += f" bounds: {bbox.get('x')},{bbox.get('y')} size: {bbox.get('width')}x{bbox.get('height')}"
        
    # Text content
    if node_type == 'TEXT':
        chars = node.get('characters', '').replace('\n', '\\n')
        style = node.get('style', {})
        font_size = style.get('fontSize')
        font_weight = style.get('fontWeight')
        font_fam = style.get('fontFamily')
        color = node.get('fills', [{}])[0].get('color')
        color_str = f"rgb({int(color.get('r',0)*255)}, {int(color.get('g',0)*255)}, {int(color.get('b',0)*255)})" if color else "N/A"
        line += f" text: '{chars}' font: {font_fam} size: {font_size} weight: {font_weight} color: {color_str}"
        
    # Background / Fills for frames / rectangles
    if node_type in ['FRAME', 'RECTANGLE']:
        fills = node.get('fills', [])
        if fills:
            fill_types = [f.get('type') for f in fills]
            line += f" fills: {fill_types}"
            
    lines.append(line)
    
    for child in node.get('children', []):
        lines.extend(format_node_summary(child, indent + 1))
        
    return lines

with open(OUTPUT_PATH, 'w') as out:
    for tid in target_ids:
        node = nodes.get(tid)
        if node:
            out.write(f"=== FRAME ID: {tid} Name: {node.get('name')} ===\n")
            summary_lines = format_node_summary(node)
            out.write("\n".join(summary_lines))
            out.write("\n\n")
        else:
            out.write(f"=== FRAME ID: {tid} NOT FOUND ===\n\n")

print("Done dumping Figma frames to figma_dump.txt")
