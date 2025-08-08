void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    bool renderGravityPoints = false;
    bool closeToGravityPoint = false;
    int maxSteps = 30000;
    vec2 screenSize = iResolution.xy;
    float longerSide = max(screenSize.x, screenSize.y);
    float drag = 0.0005;
    float minDistance = 5.0;
    float gravity = 5.0;

    vec2 pixelCoords = fragCoord.xy;

    vec3 color = vec3(1.0, 1.0, 1.0);
    
    float xCenter = screenSize.x / 2.0;
    float yCenter = screenSize.y / 2.0;

	vec2 points[10] = vec2[](
	    vec2(xCenter + cos(0.0) * 200.0,     yCenter + sin(0.0) * 200.0),
	    vec2(xCenter + cos(0.628) * 200.0,   yCenter + sin(0.628) * 200.0),
	    vec2(xCenter + cos(1.257) * 200.0,   yCenter + sin(1.257) * 200.0),
	    vec2(xCenter + cos(1.885) * 200.0,   yCenter + sin(1.885) * 200.0),
	    vec2(xCenter + cos(2.513) * 200.0,   yCenter + sin(2.513) * 200.0),
	    vec2(xCenter + cos(3.142) * 200.0,   yCenter + sin(3.142) * 200.0),
	    vec2(xCenter + cos(3.770) * 200.0,   yCenter + sin(3.770) * 200.0),
	    vec2(xCenter + cos(4.398) * 200.0,   yCenter + sin(4.398) * 200.0),
	    vec2(xCenter + cos(5.027) * 200.0,   yCenter + sin(5.027) * 200.0),
	    vec2(xCenter + cos(5.655) * 200.0,   yCenter + sin(5.655) * 200.0)
	);

    vec3 colors[10] = vec3[](
        vec3(0.0, 0.0, 0.0),
        vec3(0.05, 0.0, 0.1),
        vec3(0.2, 0.0, 0.3),
        vec3(0.4, 0.0, 0.2),
        vec3(0.6, 0.1, 0.0),
        vec3(0.8, 0.3, 0.0),
        vec3(1.0, 0.6, 0.0),
        vec3(1.0, 0.8, 0.3),
        vec3(0.9, 0.95, 1.0),
        vec3(1.0, 1.0, 1.0)
    );


    for (int i = 0; i < 10; i++) {
       if (length(fragCoord - points[i]) < minDistance) {
          if (renderGravityPoints) {
             color = vec3(0.0, 0.0, 0.0);
          } else {
             color = vec3(colors[i]);
          }

          closeToGravityPoint = true;
       }
    }

    float particleX = pixelCoords.x;
    float particleY = pixelCoords.y;

    float velocityX = 0.0;
    float velocityY = 0.0;

    int collidedPointIndex = -1;
    int stepCount = 0;



    fragColor = vec4(color, 1.0);

    while (stepCount < maxSteps) {
      if (closeToGravityPoint) break;
      stepCount++;

      float accelerationX = 0.0;
      float accelerationY = 0.0;

      for (int i = 0; i < 10; i++) {
        float pointX = points[i].x;
        float pointY = points[i].y;

        float dx = (pointX - particleX) * (512.0 / longerSide);
        float dy = (pointY - particleY) * (512.0 / longerSide);
        float distanceSquared = dx * dx + dy * dy;

        float minDistance = minDistance * (512.0 / longerSide);

        if (distanceSquared < (minDistance * minDistance)) {
          collidedPointIndex = i;
          break;
        }

        float gravityForce = gravity / distanceSquared;

        float distance = sqrt(distanceSquared);

        accelerationX += gravityForce * (dx / distance);
        accelerationY += gravityForce * (dy / distance);

      }

      if (collidedPointIndex >= 0) break;

      velocityX += accelerationX;
      velocityY += accelerationY;

      velocityX *= (1.0 - drag);
      velocityY *= (1.0 - drag);


      particleX += velocityX;
      particleY += velocityY;

    }

    if (collidedPointIndex == -1) {

      fragColor = vec4(color, 1.0);

    } else {

      fragColor = vec4(colors[collidedPointIndex], 1.0);

    }
}