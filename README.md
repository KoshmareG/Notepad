# Notepad

Version 2.0

Notepad in Ruby working from the console. The application was created in Ruby 3.1.2

You will need SQLite3 installed to work.

You can create:

* memo
* link
* task

Recordings are saved to `notepad.sqlite` file

### New entry

To create a new entry, run:

```
$ ruby new_post.rb
```

Program output:

```
> Привет, я твой блокнот! Версия 2 + Sqlite
> Что хотите записать в блокноте?
>         0. Memo
>         1. Task
>         2. Link

```

Then use numbers to indicate the type of note you are creating.

### Reading notes

To read, run:

```
$ ruby read.rb
```

Displays all saved notes. To get specific records, use the `read options`.

### Reading options

Options passed when reading:

```
--type POST_TYPE
# type of posts to read (by default, any)

--id POST_ID
# show post with specific id

--limit NUMBER
# limit entries to read

--h
# help
```

You can pass several options.

### Examples

Need to get all the links:

```
$ ruby read.rb --type Link
```

Get the 3 latest memo:

```
$ ruby read.rb --type Memo --limit 3
```

Get the last 5 entries:

```
$ ruby read.rb --limit 5
```

Entry number 5

```
$ ruby read.rb --id 5
```
