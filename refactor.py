import os
import shutil
import re

base_dir = r"d:\project\Flutter\focusappfrontend\lib"

# Desired structure
dirs_to_create = [
    "theme", "theme/screens", "theme/ui", "theme/services",
    "focus_timer", "focus_timer/screens", "focus_timer/ui", "focus_timer/services",
    "intro", "intro/screens", "intro/ui", "intro/services",
    "app_blocker", "app_blocker/screens", "app_blocker/ui", "app_blocker/services",
]

for d in dirs_to_create:
    os.makedirs(os.path.join(base_dir, d), exist_ok=True)

moves = {
    # Theme
    "core/theme/app_theme.dart": "theme/app_theme.dart",
    "core/theme/app_colors.dart": "theme/app_colors.dart",
    "core/theme/app_gradients.dart": "theme/app_gradients.dart",
    "core/theme/app_glow.dart": "theme/app_glow.dart",
    "core/theme/theme_provider.dart": "theme/services/theme_provider.dart",
    "features/focus/screens/flame_customization_screen.dart": "theme/screens/flame_customization_screen.dart",
    "features/focus/widgets/containers/glass_container.dart": "theme/ui/glass_container.dart",

    # Intro
    "features/intro/screens/splash_screen.dart": "intro/screens/splash_screen.dart",
    "features/intro/screens/onboarding_screen.dart": "intro/screens/onboarding_screen.dart",
    "features/intro/screens/permissions_screen.dart": "intro/screens/permissions_screen.dart",
    "features/intro/screens/auth_screen.dart": "intro/screens/auth_screen.dart",

    # App Blocker
    "features/focus/screens/app_blocker_screen.dart": "app_blocker/screens/app_blocker_screen.dart",

    # Focus Timer
    "features/focus/screens/focus_home_screen.dart": "focus_timer/screens/focus_home_screen.dart",
    "features/focus/screens/focus_timer_screen.dart": "focus_timer/screens/focus_timer_screen.dart",
    "features/focus/screens/analytics_screen.dart": "focus_timer/screens/analytics_screen.dart",
    "features/focus/screens/session_history_screen.dart": "focus_timer/screens/session_history_screen.dart",
    "features/focus/screens/flame_progress_screen.dart": "focus_timer/screens/flame_progress_screen.dart",

    "features/focus/widgets/navigation/bottom_navbar.dart": "focus_timer/ui/bottom_navbar.dart",
    "features/focus/widgets/stats/stat_card.dart": "focus_timer/ui/stat_card.dart",
    "features/focus/widgets/progress/circular_focus_progress.dart": "focus_timer/ui/circular_focus_progress.dart",
    "features/focus/widgets/flame/flame_widget.dart": "focus_timer/ui/flame_widget.dart",
    "features/focus/widgets/charts/focus_chart.dart": "focus_timer/ui/focus_chart.dart",
    "features/focus/widgets/buttons/focus_primary_button.dart": "focus_timer/ui/focus_primary_button.dart",
}

for src, dst in moves.items():
    src_path = os.path.join(base_dir, src)
    dst_path = os.path.join(base_dir, dst)
    if os.path.exists(src_path):
        print(f"Moving {src_path} -> {dst_path}")
        shutil.move(src_path, dst_path)
    else:
        print(f"Skipping {src_path}, not found.")

import_map = {}
for src, dst in moves.items():
    filename = os.path.basename(dst)
    # Map the bare filename to the absolute package import path
    import_map[filename] = f"package:focusappfrontend/{dst}"

# Also handle cases where imports might just be `import 'splash_screen.dart';`
# Note: we need to be careful with regex here, we replace anything that ends with the filename in quotes.

for root, _, files in os.walk(base_dir):
    for f in files:
        if not f.endswith('.dart'): continue
        filepath = os.path.join(root, f)
        
        with open(filepath, 'r', encoding='utf-8') as file:
            content = file.read()
            
        original_content = content
        for filename, full_path in import_map.items():
            # Matches import '.../filename'; or import 'filename';
            pattern = r"import\s+['\"][^'\"]*?" + re.escape(filename) + r"['\"];"
            replacement = f"import '{full_path}';"
            content = re.sub(pattern, replacement, content)
            
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as file:
                file.write(content)
            print(f"Updated imports in {filepath}")

# Optional: Clean up empty directories
import stat
def remove_readonly(func, path, excinfo):
    os.chmod(path, stat.S_IWRITE)
    func(path)

for old_dir in ["core", "features"]:
    p = os.path.join(base_dir, old_dir)
    if os.path.exists(p):
        print(f"Removing old tree: {p}")
        shutil.rmtree(p, onerror=remove_readonly)

print("Done Refactoring!")
