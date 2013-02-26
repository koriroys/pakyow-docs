# Writing Process

(add questions or comments [here](http://alpha.lifecycleapp.com/projects/12/discussions/87))

First, documentation categories topics are defined as lists and tasks in the [project](http://alpha.lifecycleapp.com/projects/12/tasks). When you begin working on a topic, click "Start" and it will be assigned to you. Feel free to ask for clarification or input at any point.

Writing itself will take place in the [pakyow-docs](https://github.com/metabahn/pakyow-docs) git repo. There is a 'docs' directory that contains a markdown file for each category and topic. The filename follows this convention:

{4 digit category num}-{4 digit topic num}-{name}.md

For example, a file named '0000-0000-first_category.md' would represent the introductory topic for a category called 'first category'. The name is unimportant and is only there to comprehend the file list.

Each file begins with a section for metadata. Take a look at an existing file for an example.

Once a topic has been written, mark the task as complete. Someone else will review the topic and provide feedback. Once feedback has been addressed it will go through the final editing process and finally be marked as accepted.

# Writing Guidelines

(add questions or comments [here](http://alpha.lifecycleapp.com/projects/12/discussions/90))

In an effort to keep final editing to a minimum, here are some guidelines to follow when writing content:

  - Be clear but not elementary. A beginner should be able to read the docs and understand how to use Pakyow, but the concepts should be described for what they are and in terms a seasoned developer can relate to.
  - Include examples as necessary (look at an existing file for a formatting example). If the example produces meaningful output, include the output as a code comment at the end of the example.
  - Add references to related concepts as applicable. This includes references to other Pakyow docs as well as core Ruby or general programming concepts. When making a reference be sure to include some details on how the reference relates to the current topic.
  - If content for a particular topic needs to be broken up, do so with level four headings. See Routing Overview for an example.
  - Keep the narrative consistent. Refer to the reader the-second person and Pakyow (framework or team) in third-person.
  - When referencing a symbol (e.g. class, method) wrap in tildes so it is formatted as `code`. If a particular class/method is being referenced format as `ClassName#method_name`. If the context is implied (e.g. the method for defining a GET route), do not include the class name.
