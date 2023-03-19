# Brainfuck Interpreter

This is a Prolog implementation of a Brainfuck interpreter. Brainfuck is an esoteric programming language with only eight commands, making it one of the simplest programming languages.

## Getting Started

### Prerequisites

To run the Brainfuck interpreter written in Prolog, you'll need to first install [SWI-Prolog](https://www.swi-prolog.org/) .

To install SWI-Prolog on Linux, open up a terminal and type:

```{bash}
sudo apt-get install swi-prolog
```

On macOS, if you have Homebrew installed you can instead run:

```{bash}
brew install swi-prolog
```

To install SWI-Prolog on Windows, download the installer from the [official website](https://www.swi-prolog.org/Download.html) and follow the instructions.

### Cloning the Repository

1. Open your terminal or command prompt and navigate to the directory where you want to clone the repository.

2. Clone the repository:
```bash
git clone https://github.com/afvanwoudenberg/bf.git
```

3. Navigate into the project folder:
```bash
cd bf
```

### Running Brainfuck Programs

Once you have SWI-Prolog installed and have cloned this repository, you can run Brainfuck programs using the `run_bf_program/1` predicate.

This repository includes some programs from the [The brainfuck archive](http://esoteric.sange.fi/brainfuck/).

First, start the SWI-Prolog interpreter by opening up a terminal and typing:

```{bash}
swipl
```

This will start the Prolog interpreter. You can then load the Brainfuck interpreter by typing:

```{prolog}
[bf].
```

This loads the `bf.pl` file into the interpreter. You can then run a Brainfuck program using the `run_bf_program/1` predicate, like so:

```{prolog}
run_bf_program('hellobf.bf').
```

This will run the `hellobf.bf` program and output the famous "Hello World!" message to the console.

Alternatively, you can execute these three steps at once by typing:

```bash
swipl -s bf.pl -g "run_bf_program('hellobf.bf'), halt."
```

Adding `halt` will make the Prolog interpreter exit after the Brainfuck `run_bf_program/1` predicate has finished.

## Author

Aswin van Woudenberg ([afvanwoudenberg](https://github.com/afvanwoudenberg))

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

