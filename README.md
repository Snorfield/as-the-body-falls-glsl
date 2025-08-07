# ☄️ as the body falls (glsl) 🌀

Forked from **as the body falls**, this readme and the example images belong to the original creator, man-o-valor. The readme has been updated for this version specifically
-
Welcome to the repository for **as the body falls (glsl)**, a ported version of **as the body falls** for a GLSL fragment shader that generates images based on falling planets. It supports custom palettes, planets, and parameters, and there's endless possibilities and permutations!

So how does this all work? Basically, you get to choose the number and position of "gravity points" on your image that have mass. Then for each pixel, it drops a little planet that falls toward the points. The point that it falls into determines the color of the pixel!

![Example 1](/example1.png)

## How do I use it?

To run out of the box, you simply need to paste index.glsl into the [shadertoy](https://www.shadertoy.com/new) GLSL environment. Positions can be changed in the points array, and you can paste palettes in from the palette file, though you need to have at least as many colors as positions.

## I don't want to use ShaderToy

This is obviously mostly valid GLSL with the exception of some variables such as `iResolution`, `fragCoord`, and `fragColor` which is used by ShaderToy. If you have decent knowlege of the environment you want to view this in, it wouldn't be hard to change the instances of the variables into the correct version for your environment. For example, in Godot's shader language, `void mainImage( out vec4 fragColor, in vec2 fragCoord )` turns into `void fragment()`, `fragColor` turns into `COLOR`, and `fragCoord` turns into `FRAGCOORD`. 

It then runs fine in Godot, perhaps applied as a shader material to a `ColorRect` node.

![Example 2](/example2.png)

## Parameter index

- renderGravityPoints: View gravity points as black dots.
    
- maxSteps: Maximum steps the program can simulate each particle.

- drag: The simplicity of the output, lower numbers generate more complex patterns

- minDistance: How close a particle needs to get to a gravity point to "collide".
    
- gravity = Precision of the output

![Example 3](/example3.png)

## Custom Palettes

The included `palettes.txt` has lots of palettes for you to try, but feel free to edit it and add your own in the same format! Please note that the palette should have at least the same number of colors as points you are simulating.

![Example 4](/example4.png)
