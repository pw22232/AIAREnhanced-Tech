# Overview of Initial Meeting with Client

## The Problem

IBM develops and releases complicated apps that have complicated documentation and processes.

* This documentation sometimes contains diagrams.
* Diagrams can be hard to understand if you are unfamiliar with the technology they are describing.

## Inspiration

AR has been incorporated into artwork, allowing users to interact with it.

* e.g. takes a 2D image and makes it appear 3D, maybe by adding snowflakes or rainfall.
  
An AI assistant is used to provide additional information about the art, such as:

* Who made it?
* Why did they make it?
* Why is it important?

Consider the concept of self-referential AR diagrams.

## Expectations

An app:

* used with a diagram that triggers AR enhancement to the diagram.
* with an AI assistant that can provide additional information about the diagram and the enhancements.

Specifically, this app should be used to enhance the diagrams in the Galasa documentation.

## Galasa

Galasa is an open-source tool made by IBM which is designed for testing software.  
It is a complex system and has complicated documentation.

## Scale

* Start with a proof of concept on either iOS or Android (no preference).
* Emphasise scalability in design.

1. Highlight relevant details to description
2. Animate moving parts/trace movements, e.g. message moving between systems
3. Research Galasa and work out which parts of it we (as outsiders) think are important
4. Create a MoSCoW list (Must-have, Should-have, Could-have, Won't-have):
    * Decide what is in/out of scope for the project.
    * Keep us on track.
    * When chossing what should go in each category, think about things in terms of:
        * a tech POV
        * a user POV
        * difficulty
        * whether it is fundamental
    * Aim for Should/Could.

## Typical Use of App

1. User opens app.
    * there is no login.
2. App opens the rear-facing camera.
3. The user holds their phone up to a diagram.
4. Diagram triggers AR enhancement.
    * highlight the component
    * explain why it is important
    * animate flow of messages/data between components so user can follow the process more easily
5. User can ask AI Assistant questions about what they are seeing and why they are seeing it.

## AI Assistant

* Consider speech-to-text and text-to-speech funcionality using Watson.
* Expore the use of open-source AI solutions.

## User Interface & Accessibility

* The main user of this app will likely be a testing engineer, some informed but new to using Galasa.
* Need to cater to both test engineers and newcomers to the tool.
* Needs to help users understand the Galasa platform and its components.

## Contract

Since Galasa is an open-source tool, this app will also be open-source.

## Future Contact with Client

* They would like to see our progress every two weeks.
* Since they are very busy and get lots of emails there is chance things will be missed and they will need to be reminded.

## What we should do

* Consider taking Designer Thinking course on Skills Build.
* Make a storyboard.
