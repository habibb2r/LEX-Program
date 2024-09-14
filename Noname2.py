import re

def simple_lexical_analyzer(input_string):
    # Define regex patterns for tokens
    token_specification = [
        ('NUMBER', r'\d+'),        # Integer or decimal number
        ('PLUS', r'\+'),           # Addition operator
        ('MINUS', r'-'),           # Subtraction operator
        ('TIMES', r'\*'),          # Multiplication operator
        ('DIVIDE', r'/'),          # Division operator
        ('LPAREN', r'\('),         # Left parenthesis
        ('RPAREN', r'\)'),         # Right parenthesis
        ('SKIP', r'[ \t]+'),       # Skip over spaces and tabs
        ('MISMATCH', r'.'),        # Any other character
    ]

    # Compile regex patterns
    token_regex = '|'.join('(?P<%s>%s)' % pair for pair in token_specification)
    get_token = re.compile(token_regex).match
    line = 1
    pos = line_start = 0
    mo = get_token(input_string)
    
    # Tokenize the input string
    while mo is not None:
        typ = mo.lastgroup
        if typ == 'NUMBER':
            value = int(mo.group(typ))
        elif typ != 'SKIP':
            value = mo.group(typ)
        else:
            value = None
        
        if typ != 'SKIP':
            print(f'Token(type={typ}, value={value})')
        
        pos = mo.end()
        mo = get_token(input_string, pos)
    
    if pos != len(input_string):
        raise RuntimeError(f'Unexpected character {input_string[pos]} at line {line}')

# Test the simple lexical analyzer
input_string = '3 + 4 * 10 + -20 / 2'
simple_lexical_analyzer(input_string)
