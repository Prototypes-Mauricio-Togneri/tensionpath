import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

final usedElements = <String>{};
final declaredElements = <String, String>{};

void main() async {
  final rootDir = Directory('lib');
  await for (final file in rootDir.list(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = await file.readAsString();
      final unit = parseString(content: content, path: file.path).unit;

      unit.visitChildren(_MethodVisitor(file.path));
    }
  }

  final unused = declaredElements.keys
      .where((m) => !usedElements.contains(m))
      .toList();

  if (unused.isEmpty) {
    print('🎉 No unused public methods found!');
  } else {
    print('🧹 Possibly unused public methods:');
    for (final method in unused) {
      print('- $method (${declaredElements[method]})');
    }
  }
}

class _MethodVisitor extends RecursiveAstVisitor<void> {
  final String filePath;

  _MethodVisitor(this.filePath);

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final name = node.name.lexeme;
    if (!name.startsWith('_')) {
      declaredElements[name] = filePath;
    }
    super.visitMethodDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    final name = node.name.lexeme;
    if (!name.startsWith('_')) {
      declaredElements[name] = filePath;
    }
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    for (final varDecl in node.fields.variables) {
      final name = varDecl.name.lexeme;
      if (!name.startsWith('_')) {
        declaredElements[name] = filePath;
      }
    }
    super.visitFieldDeclaration(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    usedElements.add(node.methodName.name);
    super.visitMethodInvocation(node);
  }

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    if (node.function is Identifier) {
      usedElements.add((node.function as Identifier).name);
    }
    super.visitFunctionExpressionInvocation(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    usedElements.add(node.propertyName.name);
    super.visitPropertyAccess(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    usedElements.add(node.identifier.name);
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    usedElements.add(node.name);
    super.visitSimpleIdentifier(node);
  }
}
