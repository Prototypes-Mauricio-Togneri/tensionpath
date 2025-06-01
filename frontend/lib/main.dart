import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

final calledMethods = <String>{};
final declaredPublicMethods = <String, String>{}; // methodName -> file

void main() async {
  final rootDir = Directory('lib');
  await for (final file in rootDir.list(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = await file.readAsString();
      final unit = parseString(content: content, path: file.path).unit;

      unit.visitChildren(_MethodVisitor(file.path));
    }
  }

  final unused = declaredPublicMethods.keys
      .where((m) => !calledMethods.contains(m))
      .toList();

  if (unused.isEmpty) {
    print('🎉 No unused public methods found!');
  } else {
    print('🧹 Possibly unused public methods:');
    for (final method in unused) {
      print('- $method (${declaredPublicMethods[method]})');
    }
  }
}

class _MethodVisitor extends RecursiveAstVisitor<void> {
  final String filePath;

  _MethodVisitor(this.filePath);

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final name = node.name.lexeme;
    if (!name.startsWith('_') && node.parent is ClassDeclaration) {
      declaredPublicMethods[name] = filePath;
    }
    super.visitMethodDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    final name = node.name.lexeme;
    if (!name.startsWith('_')) {
      declaredPublicMethods[name] = filePath;
    }
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    calledMethods.add(node.methodName.name);
    super.visitMethodInvocation(node);
  }

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    if (node.function is Identifier) {
      calledMethods.add((node.function as Identifier).name);
    }
    super.visitFunctionExpressionInvocation(node);
  }
}
