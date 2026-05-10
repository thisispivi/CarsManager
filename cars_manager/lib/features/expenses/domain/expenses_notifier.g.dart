// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expensesHash() => r'4393902fd75570b995c3981b329f25d2697c0614';

/// See also [expenses].
@ProviderFor(expenses)
final expensesProvider = AutoDisposeProvider<ExpenseCollections>.internal(
  expenses,
  name: r'expensesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExpensesRef = AutoDisposeProviderRef<ExpenseCollections>;
String _$expensesControllerHash() =>
    r'2c08fd18f39aada8795565344f12712fd5a8cb39';

/// See also [ExpensesController].
@ProviderFor(ExpensesController)
final expensesControllerProvider =
    AutoDisposeNotifierProvider<
      ExpensesController,
      ExpenseCollections
    >.internal(
      ExpensesController.new,
      name: r'expensesControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$expensesControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExpensesController = AutoDisposeNotifier<ExpenseCollections>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
