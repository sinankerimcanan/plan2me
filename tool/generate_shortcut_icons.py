"""Ana ekran kısayolu (quick actions) simgelerini Material Icons fontundan üretir.

Material Icons Apache 2.0 lisanslıdır; iOS ve Android'de kullanılabilir.
Çalıştırma: python3 tool/generate_shortcut_icons.py
"""
import json
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parent.parent
FONT = ROOT / ".fvm/flutter_sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf"

# kısayol adı -> Flutter Icons kod noktası (lib/src/material/icons.dart)
ICONS = {
    "shortcut_new_task": 0xF539,  # add_task_rounded
    "shortcut_tasks": 0xF021A,  # task_alt_rounded
    "shortcut_calendar": 0xF06C8,  # calendar_month_rounded
    "shortcut_new_project": 0xF679,  # create_new_folder_rounded
}


def glyph(codepoint: int, size: int) -> Image.Image:
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    font = ImageFont.truetype(str(FONT), size)
    d = ImageDraw.Draw(img)
    ch = chr(codepoint)
    l, t, r, b = d.textbbox((0, 0), ch, font=font)
    d.text(((size - (r - l)) / 2 - l, (size - (b - t)) / 2 - t), ch, font=font, fill=(0, 0, 0, 255))
    return img


def main():
    assets = ROOT / "ios/Runner/Assets.xcassets"
    drawable = ROOT / "android/app/src/main/res/drawable-xxhdpi"
    drawable.mkdir(parents=True, exist_ok=True)
    for name, cp in ICONS.items():
        iset = assets / f"{name}.imageset"
        iset.mkdir(parents=True, exist_ok=True)
        images = []
        for scale in (1, 2, 3):
            fname = f"{name}@{scale}x.png"
            glyph(cp, 25 * scale).save(iset / fname)
            images.append({"idiom": "universal", "filename": fname, "scale": f"{scale}x"})
        (iset / "Contents.json").write_text(
            json.dumps(
                {
                    "images": images,
                    "info": {"author": "xcode", "version": 1},
                    "properties": {"template-rendering-intent": "template"},
                },
                indent=2,
            )
        )
        glyph(cp, 96).save(drawable / f"{name}.png")
    print("Kısayol simgeleri üretildi.")


if __name__ == "__main__":
    main()
