# Design Concepts

This is a preliminary page illustrating the concepts and ideas we were exploring during the initial stages of the project. We will discuss, the ideas we had, what we took to the client and the feedback we recieved to shape the direction we took. You can see how our very first ideas materialised into a mobile application.

## Table of Contents
  - [Initial Concept](#Initial-Concept)
  - [Our MVP](#Our-MVP)
  - [Third Concept](#Project-Summary)
  - [Forth Concept](#Ambitions-for-final-product)

## Initial Concept

These are the very first ideas we had when thinking about creating the augmented reality experience. We had a lot ideas about what this might look like in theory; we also had to balance this with what was feasable given the scope of the project.

This initial Mockup presented to client was based upon the "Remote Ecosystem Diagram" 

![Remote Ecosystem](run_remote.png)

We developed conceptual designs for the augmented diagram and presented these mock-ups to the client for review and feedback. <br>

Our initial design was inspired by a specific example, which served as a foundational reference.

![First Image](IMG_1608.PNG)

Using this example as a starting point, we crafted our own unique mockup design.

![Mockup Picture 1](picture_1.png)

This design presents a visually engaging and user-friendly interface, enabling users to interact seamlessly with their documentation. In the lower left corner, you'll notice 'Watson,' a virtual assistant designed to aid in understanding the documentation. Watson is envisioned as a 3D figure, skillfully anchored within the 3D space captured by the user's camera, enhancing the overall interactive experience.

When users interact with an element within the augmented reality diagram, it will expand to offer additional, in-depth details about that specific section of the documentation. This interactive feature is designed to enhance understanding by providing context-sensitive information on-demand.

Our  design was mapped by this specific example.

![Second Image](IMG_1610.PNG)

Drawing from this example as our reference, we created an original mock-up design.

![Mockup Picture 2](picture_2.png)

Our initial concept sets the stage for development, providing a solid base from which to evolve. Below, you can trace the progression and refinement of our early designs as they undergo our iterative design process.

## Our MVP

With our initial design concepts now in place and a clear vision of what we aim to create, plus the permission of IBM to build pretty much anything. It was time to start developing.

Our first steps were getting Xcode running on our machines, learning how to develop in swift and then unserstanding how it works instrinsicly with ArKit to create the augmented experience we and most importantly the user would desire.

video

As you can see here, we have successfully integrated the iPhone's camera functionality into our application. This integration allows us to effectively anchor virtual objects, like this block, to the real-world environment captured by the camera. Additionally, we have implemented gesture recognition capabilities. As demonstrated, users can interact with the application by tapping the screen, which triggers the spawning of additional blue blocks in the augmented space.

Our next step was being able to import a 3D model into our world; blue blocks won't quite give the user the experince we are aiming for.

Video

This is a video the MVB, if your squint your eyes and look closly you can see the purple globe sat on the desk. This development marks a significant milestone in our project. We have successfully demonstrated the capability to import files in the .usdz format into our application. 
