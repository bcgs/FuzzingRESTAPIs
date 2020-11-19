grammar inventory;

start: request_line;

request_line
    : addInventoryItem
    | searchInventory
    ;

integer
    : DIGIT
    | NONZERODIGIT DIGIT+
    ;

DIGIT
    : [0-9]
    ;

NONZERODIGIT
    : [1-9]
    ;

string
    : STRINGLITERAL+
    ;

STRINGLITERAL
    : [a-zA-Z]
    ;

guid
    : BLOCK BLOCK '-' BLOCK '-' BLOCK '-' BLOCK '-' BLOCK BLOCK BLOCK
    ;

BLOCK
    : (STRINGLITERAL | NONZERODIGIT) (STRINGLITERAL | NONZERODIGIT) (STRINGLITERAL | NONZERODIGIT) (STRINGLITERAL | NONZERODIGIT)
    ;

phone
    : PHONEBLOCK '-' PHONEBLOCK '-' PHONEBLOCK NONZERODIGIT
    ;

PHONEBLOCK
    : NONZERODIGIT NONZERODIGIT NONZERODIGIT
    ;

homepage
    : 'https://www.' STRINGLITERAL+ '.com'
    ;

date
    : DATEBLOCK '/' DATEBLOCK '/19' DATEBLOCK
    ;

DATEBLOCK
    : NONZERODIGIT NONZERODIGIT
    ;

data
    : '"' OB SF 'id' SF COLLON SF guid SF COMMA SF 'name' SF COLLON SF string SF COMMA 
    SF 'releaseDate' SF COLLON releaseDate COMMA SF 'manufacturer' SF COLLON manufacturer CB '"'
    ;

manufacturer
    : OB SF 'name' SF COLLON SF string SF COMMA SF 'homePage' SF COLLON SF homepage SF COMMA SF 'phone' SF COLLON SF phone SF CB
    ;

releaseDate
    : OB date CB
    ;

OB
    : '{'
    ;

CB
    : '}'
    ;

SF
    : '\\"'
    ;

COMMA
    : ', '
    ;

COLLON
    : ': '
    ;

addInventoryItem
    : 'curl -X POST "https://virtserver.swaggerhub.com/dmusy/2048_tracking/1.0.0/inventory" -H  "accept: application/json" -H  "Content-Type: application/json" -d ' data
    ;

searchInventory
    : 'curl -X GET "https://virtserver.swaggerhub.com/dmusy/2048_tracking/1.0.0/inventory?searchString=' string '&skip=' integer '&limit=' integer '" -H  "accept: application/json"'
    ;

