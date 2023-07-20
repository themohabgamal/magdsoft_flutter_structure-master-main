// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/custom_grid/bloc/custom_grid_bloc.dart';

import 'package:magdsoft_flutter_structure/data/network/responses/product_response.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/shared/product_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/args.dart';

class CustomGridItem extends StatefulWidget {
  Products product;

  CustomGridItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CustomGridItem> createState() => _CustomGridItemState();
}

class _CustomGridItemState extends State<CustomGridItem> {
  CustomGridBloc customGridBloc = CustomGridBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomGridBloc, CustomGridState>(
      bloc: customGridBloc,
      listenWhen: (previous, current) => current is CustomGridActionState,
      buildWhen: (previous, current) => current is! CustomGridActionState,
      listener: (context, state) {
        if (state is NavigateToProductScreenState) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ProductScreen(
                  myArgs: MyArgs(
                      imageUrl: widget.product.image!,
                      company: widget.product.company!,
                      description: widget.product.description!,
                      price: widget.product.price!,
                      name: widget.product.name!)),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: InkWell(
            onTap: () {
              customGridBloc.add(NavigateToProductScreenEvent());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.product.image ?? "",
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.product.name ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.product.company ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.price ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Add laptop to cart
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
