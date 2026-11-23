"""Builds the launcher icon set and the 512px Play Store icon from the brand logo.

    PYTHONPATH=/path/to/pillow python3 tool/store_assets/make_icons.py

Needs Pillow (`pip install pillow`). Run from the project root.
"""
from PIL import Image, ImageChops, ImageDraw, ImageFont
import os

CREAM = (251, 247, 241, 255)
NAVY = (27, 40, 56, 255)
AMBER = (255, 160, 0, 255)
LOGO = "assets/images/wudsy_nfc_logo.png"
FONT = "google_fonts/SourceSans3-Bold.ttf"
RES = "android/app/src/main/res"
OUT = "store_assets"
S = 1024


def load_logo():
    """The logo PNG has an opaque white background; turn white into transparency."""
    img = Image.open(LOGO).convert("RGB")
    r, g, b = img.split()
    darkest = ImageChops.darker(ImageChops.darker(r, g), b)
    alpha = darkest.point(lambda v: min(255, int((255 - v) * 255 / 155)))
    # Anti-aliased edge pixels get a solid brown so no white halo shows.
    edge = alpha.point(lambda a: 255 if a < 255 else 0)
    img.paste(Image.new("RGB", img.size, (72, 46, 36)), mask=edge)
    out = img.convert("RGBA")
    out.putalpha(alpha)
    return out


def artwork(scale=1.0, background=True):
    """The icon artwork on a 1024 canvas; `scale` shrinks it toward the centre."""
    canvas = Image.new("RGBA", (S, S), CREAM if background else (0, 0, 0, 0))
    logo = load_logo()
    bbox = logo.getbbox()
    logo = logo.crop(bbox)
    w = int(800 * scale)
    h = int(logo.height * w / logo.width)
    logo = logo.resize((w, h), Image.LANCZOS)

    pill_w, pill_h = int(330 * scale), int(160 * scale)
    gap = int(70 * scale)
    block_h = h + gap + pill_h
    top = (S - block_h) // 2
    canvas.alpha_composite(logo, ((S - w) // 2, top))

    d = ImageDraw.Draw(canvas)
    px, py = (S - pill_w) // 2, top + h + gap
    d.rounded_rectangle((px, py, px + pill_w, py + pill_h), radius=pill_h // 2, fill=NAVY)
    font = ImageFont.truetype(FONT, int(120 * scale))
    d.text((S // 2, py + pill_h // 2 + int(4 * scale)), "QC", font=font, fill=AMBER, anchor="mm")
    return canvas


def save(img, path, size):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    img.resize((size, size), Image.LANCZOS).save(path)
    print(path, size)


def main():
    full = artwork(1.0, True)
    save(full, f"{OUT}/play_icon_512.png", 512)

    # Legacy square launcher icons (pre-Android 8).
    for dpi, px in {"mdpi": 48, "hdpi": 72, "xhdpi": 96, "xxhdpi": 144, "xxxhdpi": 192}.items():
        save(full, f"{RES}/mipmap-{dpi}/ic_launcher.png", px)

    # Adaptive icon (Android 8+): artwork must sit inside the centre 66%.
    fg = artwork(0.62, False)
    for dpi, px in {"mdpi": 108, "hdpi": 162, "xhdpi": 216, "xxhdpi": 324, "xxxhdpi": 432}.items():
        save(fg, f"{RES}/mipmap-{dpi}/ic_launcher_foreground.png", px)

    os.makedirs(f"{RES}/mipmap-anydpi-v26", exist_ok=True)
    with open(f"{RES}/mipmap-anydpi-v26/ic_launcher.xml", "w") as f:
        f.write(
            '<?xml version="1.0" encoding="utf-8"?>\n'
            '<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">\n'
            '    <background android:drawable="@color/ic_launcher_background"/>\n'
            '    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>\n'
            '</adaptive-icon>\n'
        )
    with open(f"{RES}/values/ic_launcher_background.xml", "w") as f:
        f.write(
            '<?xml version="1.0" encoding="utf-8"?>\n'
            "<resources>\n"
            '    <color name="ic_launcher_background">#FBF7F1</color>\n'
            "</resources>\n"
        )


if __name__ == "__main__":
    main()
