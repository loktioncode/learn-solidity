// A mapping to store a user's age:
mapping (uint => uint) public age;

// Modifier that requires this user to be older than a certain age:
modifier olderThan(uint _age, uint _userId) {
  require(age[_userId] >= _age);
  _;
}

// Must be older than 16 to drive a car (in the US, at least).
// We can call the `olderThan` modifier with arguments like so:
function driveCar(uint _userId) public olderThan(16, _userId) {
  // Some function logic
}

// You can see here that the olderThan modifier takes 
// arguments just like a function does. And 
// that the driveCar function passes its arguments to the modifier.


//create an memory array
function getArray() external pure returns(uint[] memory) {
  // Instantiate a new array in memory with a length of 3
  uint[] memory values = new uint[](3);

  // Put some values to it
  values[0] = 1;
  values[1] = 2;
  values[2] = 3;

  return values;
}

//for loop to add even numbers to an Array


function getEvens() pure external returns(uint[] memory) {
  uint[] memory evens = new uint[](5);
  // Keep track of the index in the new array:
  uint counter = 0;
  // Iterate 1 through 10 with a for loop:
  for (uint i = 1; i <= 10; i++) {
    // If `i` is even...
    if (i % 2 == 0) {
      // Add it to our array
      evens[counter] = i;
      // Increment counter to the next empty index in `evens`:
      counter++;
    }
  }
  return evens;
}
