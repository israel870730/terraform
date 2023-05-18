#Output usando count string o #, accediendo al segundo elemento de la lista
output "arn_usuario_usando_count" {
    description = "Arn del user 2"
    value = aws_iam_user.ejemplo[2].arn
}

#Output de una lista[] usando type = set(string) o type = number, , uso el "for"
/*output "arn_todos_usuario_usando_count" {
    description = "Arn de los usuarios"
    //Si queremos imprimir una lista
    //value = [for <iterador> in aws_iam_user.ejemplo : usuario.recurso]
    value = [for usuario in aws_iam_user.ejemplo : usuario.arn]
}*/

#Output para el for_each, accediendo al nombre karla de la lista
/*output "arn_usuario_usando_for_each" {
    description = "Arn del user 2"
    value = aws_iam_user.ejemplo["karla"].arn
}*/

#Output de un mapa{} usando un for_each, , uso el "for"
/*output "arn_y_usuario_usando_mapa" {
    description = "Arn de los usuarios"
    value = {for usuario in aws_iam_user.ejemplo : usuario.name => usuario.arn}
}*/

#Output de una lista[], uso el "for"
/*output "nombre_todos_usuario_usando_for_each" {
    description = "Arn de los usuarios"
    //value = [for <iterador> in aws_iam_user.ejemplo : usuario.recurso]
    value = [for usuario in aws_iam_user.ejemplo : usuario.name]
}*/

//Output usando "Splat"
output "arn_de_todos_los_usuarios_usando_splat" {
    //value = aws_iam_user.ejemplo[*].arn
    value = aws_iam_user.ejemplo[*].name
}