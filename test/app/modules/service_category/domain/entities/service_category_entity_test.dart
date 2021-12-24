import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  ServiceCategoryEntity serviceCategoryEntity = ServiceCategoryEntity(
      id: 1,
      name: 'Cabelo',
      picture: 'www.picture.com'
  );

  test('Espero que a entidade não seja nula ', () {
    expect(serviceCategoryEntity, isNotNull);
  });
}