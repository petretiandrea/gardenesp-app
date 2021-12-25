import 'package:dartz/dartz.dart';

class OrderByComparator<A> extends Order<A> {
  final int Function(A e1, A e2) comparator;

  OrderByComparator({required this.comparator});

  @override
  Ordering order(A a1, A a2) {
    final compare = comparator(a1, a2);
    return compare < 0
        ? Ordering.LT
        : (compare > 0 ? Ordering.GT : Ordering.EQ);
  }
}

IList<T> emptyList<T>() => Nil();

extension IListExtension<T> on IList<T> {
  IList<T> sortBy(int comparator(T e1, T e2)) {
    return this.sort(OrderByComparator(comparator: comparator));
  }
}

extension IterableExtension<T> on Iterable<T> {
  IList<T> toImmutableList() => IList.from(this);
}
