import os
import shutil
import stat
import re

base_dir = r"d:\project\Flutter\focusappfrontend\lib"

moves = {
    "features/focus/widgets/containers/blur_container.dart": "theme/ui/blur_container.dart",
    "features/focus/widgets/flame/flame_level_indicator.dart": "focus_timer/ui/flame_level_indicator.dart"
}

for src, dst in moves.items():
    src_path = os.path.join(base_dir, src)
    dst_path = os.path.join(base_dir, dst)
    if os.path.exists(src_path):
        os.makedirs(os.path.dirname(dst_path), exist_ok=True)
        shutil.copy2(src_path, dst_path)
        print(f"Copied {src_path} -> {dst_path}")

import_map = {
    "blur_container.dart": "package:focusappfrontend/theme/ui/blur_container.dart",
    "flame_level_indicator.dart": "package:focusappfrontend/focus_timer/ui/flame_level_indicator.dart",
}

for root, _, files in os.walk(base_dir):
    for f in files:
        if not f.endswith('.dart'): continue
        if "core" in root.split(os.sep) or "features" in root.split(os.sep): 
            continue
            
        filepath = os.path.join(root, f)
        
        with open(filepath, 'r', encoding='utf-8') as file:
            content = file.read()
            
        original_content = content
        for filename, full_path in import_map.items():
            pattern = r"import\s+['\"][^'\"]*?" + re.escape(filename) + r"['\"];"
            replacement = f"import '{full_path}';"
            content = re.sub(pattern, replacement, content)
            
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as file:
                file.write(content)
            print(f"Updated imports in {filepath}")

def remove_readonly(func, path, excinfo):
    try:
        os.chmod(path, stat.S_IWRITE)
        func(path)
    except Exception as e:
        print(f"Failed to remove {path}: {e}")

for old_dir in ["core", "features"]:
    p = os.path.join(base_dir, old_dir)
    if os.path.exists(p):
        print(f"Removing {p}")
        shutil.rmtree(p, onerror=remove_readonly)
