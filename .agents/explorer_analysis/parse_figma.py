import json

with open('/Users/polinapogosyan/.gemini/antigravity/scratch/figma_full.json', 'r') as f:
    data = json.load(f)

print("figma_full.json keys:", list(data.keys()))
if 'document' in data:
    doc = data['document']
    print("document keys:", list(doc.keys()))
    if 'children' in doc:
        print("Number of pages/children under document:", len(doc['children']))
        for i, child in enumerate(doc['children']):
            print(f"Child {i}: id={child.get('id')}, name={child.get('name')}, type={child.get('type')}")
            # print children of each page
            if 'children' in child:
                print(f"  Number of children on page {child.get('name')}:", len(child['children']))
                # print first few children
                for j, sub_child in enumerate(child['children'][:10]):
                    print(f"    Sub-child {j}: id={sub_child.get('id')}, name={sub_child.get('name')}, type={sub_child.get('type')}, absoluteBoundingBox={sub_child.get('absoluteBoundingBox')}")
                if len(child['children']) > 10:
                    print("    ...")
else:
    # Print the top level keys
    print("No 'document' key in JSON")
