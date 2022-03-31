import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'cart_products_record.g.dart';

abstract class CartProductsRecord
    implements Built<CartProductsRecord, CartProductsRecordBuilder> {
  static Serializer<CartProductsRecord> get serializer =>
      _$cartProductsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'service_code')
  String get serviceCode;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CartProductsRecordBuilder builder) =>
      builder..serviceCode = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cart_products');

  static Stream<CartProductsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CartProductsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  CartProductsRecord._();
  factory CartProductsRecord(
          [void Function(CartProductsRecordBuilder) updates]) =
      _$CartProductsRecord;

  static CartProductsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCartProductsRecordData({
  String serviceCode,
}) =>
    serializers.toFirestore(CartProductsRecord.serializer,
        CartProductsRecord((c) => c..serviceCode = serviceCode));
