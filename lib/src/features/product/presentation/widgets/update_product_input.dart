import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_form/product_form_bloc.dart';
import 'product_text_field.dart';

class UpdateProductInputWidget extends StatelessWidget {
  final String productName;
  final String productPrice;
  const UpdateProductInputWidget({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<ProductFormBloc>();

    return Column(
      children: [
        ProductTextField(
          label: "product_name".tr(),
          initialValue: productName,
          onChanged: (val) {
            formBloc.add(ProductNameChangedEvent(val));
          },
          hinText: "insert_product_name".tr(),
        ),
        ProductTextField(
          label: "product_price".tr(),
          initialValue: productPrice,
          onChanged: (val) {
            formBloc.add(ProductPriceChangedEvent(val));
          },
          inputType: TextInputType.number,
          inputFormat: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          hinText: "insert_product_price".tr(),
        ),
        BlocSelector<ProductFormBloc, ProductFormState, String>(
          selector: (state) => state.price,
          builder: (_, state) {
            final price = int.tryParse(state) ?? 0;
            if (price > 0 && price <= 10000) {
              return Chip(
                label: Text("cheap".tr()),
                backgroundColor: Colors.green,
              );
            } else if (price > 10000 && price <= 100000) {
              return Chip(
                label: Text("medium".tr()),
                backgroundColor: Colors.orange,
              );
            } else if (price > 100000) {
              return Chip(
                label: Text("expensive".tr()),
                backgroundColor: Colors.red,
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
