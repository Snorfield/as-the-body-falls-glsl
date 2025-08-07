void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    // Toggle gravity points
    bool renderGravityPoints = true;
    
    // Max simulation steps
    int maxSteps = 30000;
    
    // Default drag value
    float drag = 0.0;
    
    // How close does a particle need to be to "collide"?
    float minDistance = 5.0;
    
    // Default Gravity
    float gravity = 4.0;
    
    
    // Default Positions   
    vec2 points[4] = vec2[](
        vec2(37.12, 45.67),
        vec2(198.34, 123.45),
        vec2(319.78, 200.22),
        vec2(410.56, 10.89)
    );

    // Default Color Palette (Needs to have at least as many colors as positions) 
    vec3 colors[4] = vec3[4](
        vec3(0.8, 0.7, 0.9),  
        vec3(0.7, 0.9, 0.8),  
        vec3(0.9, 0.8, 0.7),  
        vec3(0.9, 0.9, 0.7)   
    );
    
    bool closeToGravityPoint = false;
    vec2 screenSize = iResolution.xy;
    float longerSide = max(screenSize.x, screenSize.y);   
    vec2 pixelCoords = fragCoord.xy;

    vec3 color = vec3(1.0, 1.0, 1.0);
    

    for (int i = 0; i < 4; i++) {   
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
      
      for (int i = 0; i < 4; i++) {
        float pointX = points[i].x;
        float pointY = points[i].y;
        
        float dx = (pointX - particleX) * (512.0 / longerSide);
        float dy = (pointY - particleY) * (512.0 / longerSide);
        float distanceSquared = dx * dx + dy * dy;
        
        float minDistance = 5.0 * (512.0 / longerSide); 
        
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
  }
}

drawImage();
