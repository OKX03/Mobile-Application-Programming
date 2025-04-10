void main() {

    //Question 1
    // a. firstName : String
    String firstName;

    // b. lastName : String
    String lastName;

    // c. num1 : integer
    int num1;

    // d. num2 : double
    double num2;

    // e. add1 : type not specified (use var)
    var add1;

    // f. nameState : boolean
    bool nameState;

    // g. middleName : String that can be null
    String? middleName;

    //Question 2
    firstName = "Oh";
    lastName = "Kai Xuan";
    print('Hello, my name is $firstName $lastName');

    //Question 3
    //a
    print(getSum(1, 2));
    //b
    print(getSum2(num1: 10));

    //Question 4
    Car car = Car("Perodua","Myvi","Silver");
    car.registrationInfo("A001", "A22EC0099");

    //Question 5
    String fullName;
    //a
    fullName = printName(firstName, lastName);
    //b
    fullName = printName2(firstName, lastName);

}

//Question 3 
//a
int getSum(int num1, int num2){
  int sum = num1 + num2;
  return sum;
}

//b
int getSum2({required int num1, int num2 = 5}){
  int sum = num1 + num2;
  return sum;
}

//Question 4
class Car{
  String carName;
  String carModel;
  String carColour;

  Car(this.carName, this.carModel, this.carColour);

  void registrationInfo(String numberPlate, String userID){
    print('Car Name: $carName');
    print('Car Model: $carModel');
    print('Car Colour: $carColour');
    print('Number Plate: $numberPlate');
    print('User ID: $userID');
  }
}

//Question 5
//a
String printName(String firstName, String lastName, [String? middleName]) {
  String fullName;
  if (middleName != null) {
    fullName = firstName + middleName + lastName;

  } else {
    fullName = firstName + lastName;
  }    
  print('$fullName');
  return fullName;
}

//b
String printName2(String firstName, String lastName, [String? middleName]) {
  String fullName;
  int loop;
  if (middleName != null) {
    fullName = firstName + middleName + lastName;
    loop = 5;
  } else {
    fullName = firstName + lastName;
    loop = 3;
  }  

  int count = 0;  
  while(count<loop){
    print('$fullName');   
    count++; 
  }

  return fullName;
}


