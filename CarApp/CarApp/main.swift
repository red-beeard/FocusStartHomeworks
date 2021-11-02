//
//  main.swift
//  CarApp
//
//  Created by Red Beard on 31.10.2021.
//


func strongReadLine(with text: String) -> String {
    while true {
        print(text, terminator: "")
        let input = readLine()
        
        if let input = input {
            return input
        }
    }
}

func weakReadLine(with text: String) -> String? {
    print(text, terminator: "")
    let input = readLine()
    
    if let input = input, input.isEmpty == false {
        return input
    }
    return nil
}

func showMenu() {
    print()
    for command in Command.allCases {
        print("\(command.rawValue). \(command)")
    }
}

func getCommand() -> Command {
    while true {
        let input = strongReadLine(with: "Введите команду -> ")
        
        if let number = Int(input), let command = Command(rawValue: number) {
            return command
        }
    }
}

func showSupportedCarBodies() {
    print("\nДоступные виды кузовов")
    for (index, body) in CarBody.allCases.enumerated() {
        print("\t\(index). \(body.rawValue)")
    }
}

func getCarBody() -> CarBody {
    showSupportedCarBodies()
    
    let input = strongReadLine(with: "Выберите кузов -> ")
    
    guard let number = Int(input) else { return .unknown }
    return CarBody(index: number)
}

func getYearOfIssue() -> Int? {
    let input = weakReadLine(with: "Введите год выпуска (необязательно) -> ")
    
    if let input = input, let year = Int(input) {
        return year
    }
    return nil
}

func addNewCar(to cars: [Car]) -> [Car] {
    var copyCars = cars
    
    let manufacturer = strongReadLine(with: "Введите производителя -> ")
    let model = strongReadLine(with: "Введите модель -> ")
    let body = getCarBody()
    let yearOfIssue = getYearOfIssue()
    let carNumber = weakReadLine(with: "Введите гос. номер (необязательно) -> ")
    
    copyCars.append(
        Car(
            manufacturer: manufacturer,
            model: model,
            body: body,
            yearOfIssue: yearOfIssue,
            carNumber: carNumber
        )
    )
    return copyCars
}

func showAddingCars(from cars: [Car], withBody: Bool = false) {
    let body = withBody == true ? getCarBody() : nil
    
    print()
    cars.filter {
        body == nil || $0.body == body
    }.forEach { print($0) }
}

func run() {
    var cars = [Car]()
    
    print("Добро пожаловать!")
    while true {
        showMenu()
        print()
        let command = getCommand()
        print()
        
        switch command {
        case .add:
            cars = addNewCar(to: cars)
        case .show:
            showAddingCars(from: cars)
        case .showFilter:
            showAddingCars(from: cars, withBody: true)
        case .exit:
            return
        }
    }
}

run()

