# About

Trying the most basic example of this rendering oddity I'm seeing. On a normal
desktop this html/script will paint the bottom right of the image.

The HTML/code crops the bottom-right part of the image and paints it (taking
the bottom-most/right-most pixels of the window) on a canvas. So if your
document height is 100\*100, it crops the bottom-right 100\*100 pixels of the
image and paints them using
[drawImage](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage).

The image I'm using is from a free D&D campaign. It's 4950*6750 and just over 4mb in size. I
think the important thing is the size...

On a memory constrained platform, like chrome in an android emulator or silk on
a firestick, the image is reduced in size by the browser before it gets to the 
javascript. In my case, silk on a firestick, the image is reduced to 3713*5063
-- a factor of about 0.75. This is where the code stops working. Instead of painting
the image you get a black canvas.  *BUT* what I cannot explain (and have discovered)
through trial an error if you *further* reduce the sx and sy parameters again by the
factor the image was shurnk (0.75) it displays as expected.  Just to be clear what I
observe is:

- An image that is 4950\*6750 is shrank to 3713\*5063 on a firestick
- `drawImage(2733, 4573, 980, 490, 0, 0, 980, 490)` paints black
- `drawImage(2049, 3429, 980, 490, 0, 0, 980, 490)` paints the expect bottom right of the image

However, working backwards from that math `2049 + 980=3029 < 3713` and 
`3429 + 490 = 3919 < 5063`. I *think* this edge case is unexpected and undesired behavior.

# Setup

1. Get the big image (dnd beyond free campaign)

```
curl "https://media.dndbeyond.com/compendium-images/lmop/M14LHJMMQhUuZ46S/map-4.1-Wave-Echo-Cave-player.jpg" -o bigimg.jpg
```

2. Build docker

```
docker build . -t renderbug:latest
```

3. Start docker

```
docker run --name some-nginx -d -p 8080:80 renderbug:latest
```