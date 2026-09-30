import 'dart:convert';

final class RouteExtraCodec extends Codec<Object?, Object?> {
  const RouteExtraCodec();

  @override
  Converter<Object?, Object?> get encoder => const _PrimitiveOnlyConverter();

  @override
  Converter<Object?, Object?> get decoder => const _PrimitiveOnlyConverter();
}

final class _PrimitiveOnlyConverter extends Converter<Object?, Object?> {
  const _PrimitiveOnlyConverter();

  @override
  Object? convert(Object? input) =>
      input is String || input is num || input is bool ? input : null;
}
