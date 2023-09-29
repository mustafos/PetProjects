//
//  main.swift
//  FirstApp
//
//  Created by Mustafa Bekirov on 01.09.2022.
//

import Foundation

print("Введите первое значение")
// получение первого значения
var a = readLine()
print("Введите второе значение")
// получение второго значения
var b = readLine()

let result = sum(a, b)
print("Результат сложения - \(result)")

func sum(_ a: String?, _ b: String?) -> Int {
    return Int(a!)! + Int(b!)!
}
//_____________________________________________
// Случайное число
let randomNumber = UInt8.random(in: 1...250)
print("Введите вариант числа от 1 до 250 и нажмите Enter")
// флаг-указатель на победу
var isWin = false
repeat {
    // попытка преобразования введенного значения к UInt8
    guard let userNumber = UInt8(readLine() ?? "") else {
        print("Вы ввели некорректное число. Попробуйте снова")
continue }
    // проверка введенного числа
    if userNumber < randomNumber{
        print("Ваш вариант меньше загаданного числа")
    } else if userNumber > randomNumber {
        print("Ваш вариант больше загаданного числа")
    } else {
        print("Вы угадали")
isWin = true }
} while !isWin
