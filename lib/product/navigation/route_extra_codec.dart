import 'dart:convert';

/// Tarayıcı geçmişine (web geri/ileri) yazılan `extra`'yı serileştirir.
///
/// Codec olmadan go_router `extra`'yı `toJson` ile yazar ve geri `Map` olarak
/// okur; typed rotadaki `state.extra as StoreModel?` cast'i patlar. Burada
/// yalnızca JSON'a birebir dönen basit değerler korunur, model nesneleri
/// düşürülür: rota `$extra` olmadan path'teki id ile açılabilmelidir.
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
