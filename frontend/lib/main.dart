import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

void main(List<String> args) async {
  final Map<String, String> declaredElements = {};
  final Set<String> usedElements = {};
  final List<String> whitelist = args.length > 1
      ? args[1].split(',').map((e) => e.trim()).toList()
      : [];

  final String rootPath = args[0];
  final Directory rootDir = Directory(rootPath);

  await for (final FileSystemEntity file in rootDir.list(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      final String content = await file.readAsString();
      final CompilationUnit unit = parseString(
        content: content,
        path: file.path,
      ).unit;
      unit.visitChildren(
        _MethodVisitor(
          filePath: file.path,
          declaredElements: declaredElements,
          usedElements: usedElements,
          whitelist: whitelist,
        ),
      );
    }
  }

  final List<String> unused = declaredElements.keys
      .where((e) => !usedElements.contains(e))
      .toList();

  if (unused.isEmpty) {
    print('🎉 No unused public methods found!');
  } else {
    print('🧹 ${unused.length} possibly unused public methods:');
    for (final String method in unused) {
      print('$method: ${declaredElements[method]}');
    }
  }
}

class _MethodVisitor extends RecursiveAstVisitor<void> {
  final String filePath;
  final Map<String, String> declaredElements;
  final Set<String> usedElements;
  final List<String> whitelist;

  _MethodVisitor({
    required this.filePath,
    required this.declaredElements,
    required this.usedElements,
    required this.whitelist,
  });

  void _addDeclaredElement(String name) {
    if (!name.startsWith('_') && !whitelist.contains(name)) {
      declaredElements[name] = filePath;
    }
  }

  void _addUsedElement(String name) {
    usedElements.add(name);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final name = node.name.lexeme;
    _addDeclaredElement(name);
    super.visitMethodDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    final name = node.name.lexeme;
    _addDeclaredElement(name);
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    for (final varDecl in node.fields.variables) {
      final name = varDecl.name.lexeme;
      _addDeclaredElement(name);
    }
    super.visitFieldDeclaration(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    _addUsedElement(node.methodName.name);
    super.visitMethodInvocation(node);
  }

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    if (node.function is Identifier) {
      _addUsedElement((node.function as Identifier).name);
    }
    super.visitFunctionExpressionInvocation(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    _addUsedElement(node.propertyName.name);
    super.visitPropertyAccess(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    _addUsedElement(node.identifier.name);
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    _addUsedElement(node.name);
    super.visitSimpleIdentifier(node);
  }
}
