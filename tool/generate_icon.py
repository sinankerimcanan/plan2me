"""plan2me uygulama ikonunu üretir.

Çalıştırma:  python3 tool/generate_icon.py
Çıktılar:    assets/icon/app_icon.png            (1024, tam zemin, iOS/web)
             assets/icon/app_icon_foreground.png (1024, şeffaf, Android adaptive)
Sonra:       fvm dart run flutter_launcher_icons
"""
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

S = 1024
OUT = Path(__file__).resolve().parent.parent / "assets" / "icon"

# Tema renkleri (lib/core/theme/color_schemes.dart ile uyumlu)
LIME_LIGHT = (226, 244, 150)
LIME_DEEP = (94, 148, 16)
YELLOW = (255, 226, 102)
OLIVE = (28, 46, 0)
WHITE = (255, 255, 255)


def lerp(a, b, t):
    return tuple(round(x + (y - x) * t) for x, y in zip(a, b))


def background() -> Image.Image:
    img = Image.new("RGB", (S, S))
    px = img.load()
    for y in range(S):
        for x in range(S):
            # Sol üstten sağ alta çapraz gradyan
            t = (x + y) / (2 * S)
            px[x, y] = lerp(LIME_LIGHT, LIME_DEEP, t ** 1.3)
    img = img.convert("RGBA")
    # Sağ üstte sıcak sarı parıltı ("sıvı" ışık)
    glow = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    ImageDraw.Draw(glow).ellipse((520, -260, 1260, 480), fill=YELLOW + (150,))
    img.alpha_composite(glow.filter(ImageFilter.GaussianBlur(140)))
    return img


def board(scale: float = 1.0) -> Image.Image:
    """Cam panel + üç kanban sütunu. scale<1 Android güvenli alanı için küçültür."""
    layer = Image.new("RGBA", (S, S), (0, 0, 0, 0))

    def box(x0, y0, x1, y1):
        c = S / 2
        return tuple(round(c + (v - c) * scale) for v in (x0, y0, x1, y1))

    r = lambda v: max(1, round(v * scale))  # noqa: E731

    panel = box(150, 150, 874, 874)
    radius = r(180)

    # Gölge sadece panelin DIŞINA düşsün (cam içinden bulanık görünmesin)
    mask = Image.new("L", (S, S), 0)
    ImageDraw.Draw(mask).rounded_rectangle(panel, radius, fill=255)
    shadow = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    sx = box(150, 186, 874, 910)
    ImageDraw.Draw(shadow).rounded_rectangle(sx, radius, fill=(46, 80, 0, 120))
    shadow = shadow.filter(ImageFilter.GaussianBlur(r(40)))
    shadow.putalpha(Image.composite(Image.new("L", (S, S), 0), shadow.getchannel("A"), mask))
    layer.alpha_composite(shadow)

    # Cam panel: dikey olarak üstte daha parlak
    glass = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    grad = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    gp = grad.load()
    y0p, y1p = panel[1], panel[3]
    for y in range(y0p, y1p):
        a = round(150 - 60 * (y - y0p) / max(1, y1p - y0p))
        for x in range(panel[0], panel[2]):
            gp[x, y] = WHITE + (a,)
    glass.paste(grad, (0, 0), mask)
    ImageDraw.Draw(glass).rounded_rectangle(panel, radius, outline=WHITE + (225,), width=r(12))
    layer.alpha_composite(glass)

    d = ImageDraw.Draw(layer)
    # Sütunlar: (x0, x1, kart sayısı)
    cols = [(226, 400, 2), (425, 599, 3), (624, 798, 1)]
    card_h, gap, top = 148, 30, 238
    tag_colors = [(124, 179, 66, 255), (240, 190, 20, 255)]
    for i, (x0, x1, n) in enumerate(cols):
        for k in range(n):
            y0 = top + k * (card_h + gap)
            done = i == 2
            d.rounded_rectangle(box(x0, y0, x1, y0 + card_h), r(40),
                                fill=OLIVE + (240,) if done else WHITE + (250,))
            if not done:
                d.rounded_rectangle(box(x0 + 26, y0 + 30, x0 + 108, y0 + 52), r(11),
                                    fill=tag_colors[(i + k) % 2])
                d.rounded_rectangle(box(x0 + 26, y0 + 78, x1 - 30, y0 + 96), r(9),
                                    fill=(210, 222, 190, 255))
    # Tamamlandı kartında onay işareti
    cx0, cy0, cx1, cy1 = box(624, top, 798, top + card_h)
    w, h = cx1 - cx0, cy1 - cy0
    d.line([(cx0 + w * 0.27, cy0 + h * 0.53), (cx0 + w * 0.44, cy0 + h * 0.72), (cx0 + w * 0.75, cy0 + h * 0.32)],
           fill=(214, 238, 143, 255), width=r(20), joint="curve")
    return layer


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    full = background()
    full.alpha_composite(board())
    full.convert("RGB").save(OUT / "app_icon.png")  # iOS: alfa kanalı olmamalı

    # Android adaptive: içerik merkezdeki ~%66 güvenli alana sığmalı
    fg = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    fg.alpha_composite(board(scale=0.70))
    fg.save(OUT / "app_icon_foreground.png")
    background().convert("RGB").save(OUT / "app_icon_background.png")
    print("İkonlar üretildi:", OUT)


if __name__ == "__main__":
    main()
