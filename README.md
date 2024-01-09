# ReactAi

Welcome to ```react_ai``` a gemified version of [my attempt to recreate the ReAct pattern in Ruby](https://github.com/thedayisntgray/Ruby-ReAct-Agent) with added features.

## Purpose

The [ReAct pattern](https://arxiv.org/abs/2210.03629) is a technique used to circumvent the limitation LLMs have of only being able to respond past the date they were trained. We do this by prompting our LLM to use tools that we can define for it. Another advantage of using tools is that we can reduce hallucinations and therefore improve accuracy of LLM responses.

## Features

### Tools
- Calculator
- Wikipedia

### CLI 
- A simple CLI tool to test prompts

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add react_ai

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install react_ai

Create a ```.env``` file in the root directory and add your open-ai key and your're ready to go!🔥

```
OPEN_AI_KEY='your open ai key'
```

## Usage

You can use this gem via the commmand line after it is installed by typing:

```./exe/react_ai "Some prompt for our LLM!"```

Here's an example of what a user prompt and subsequent response might look like:


https://github.com/thedayisntgray/react_ai/assets/4859128/bbc6cba8-914b-4d6a-9a45-77e819acaec2

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thedayisntgray/react_ai.
