<div align="center">
    <h1>Monster</h1>
    <h3>Monster Markup Generator</h3>
</div>

An experimental generator for the Monster markup generator. This is
not a complete project, and there is still plenty wrong with it but
it is so far just a basic proof of concept.

## How to use it:
* Install the V programming language compiler
* Open a terminal in the `test/` directory
* run `v run ../src/monster.v index.monster index.html`

## Files:
* `*.mc` - Monster componant files, these are read by the MonsterFile
* `MonsterFile` - Combines and names all of the components
* `*.monster` - The page file you have made

## Why?
I made Monster because I wanted to make HTML components so I can work with
TailwindCSS without my initial code being an eye sore. 