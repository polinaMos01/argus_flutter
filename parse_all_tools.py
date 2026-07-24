import json

transcript_path = "/Users/polinapogosyan/.gemini/antigravity/brain/786727cf-c97b-454b-ba59-4fa0b6d3e77a/.system_generated/logs/transcript_full.jsonl"
with open(transcript_path, 'r') as f:
    for line in f:
        try:
            entry = json.loads(line)
        except:
            continue
        if entry.get("type") == "PLANNER_RESPONSE" and "tool_calls" in entry:
            for call in entry["tool_calls"]:
                name = call.get("name")
                args = call.get("args", {})
                if name in ["write_to_file", "replace_file_content", "multi_replace_file_content"]:
                    if "notifications_screen" in args.get("TargetFile", ""):
                        print(f"Step {entry['step_index']}: {name} on notifications_screen")
