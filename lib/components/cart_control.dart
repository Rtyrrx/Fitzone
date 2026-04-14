import 'package:flutter/material.dart';

class CartControl extends StatefulWidget {
  final void Function(int) addToCart;

  const CartControl({super.key, required this.addToCart});

  @override
  State<CartControl> createState() => _CartControlState();
}

class _CartControlState extends State<CartControl> {
  int _cartNumber = 1;

  Widget _buildMinusButton() {
    return IconButton(
      onPressed: _cartNumber > 1
          ? () {
              setState(() {
                _cartNumber--;
              });
            }
          : null,
      icon: const Icon(Icons.remove_circle_outline),
      iconSize: 32,
    );
  }

  Widget _buildCartNumberContainer(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$_cartNumber',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildPlusButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _cartNumber++;
        });
      },
      icon: const Icon(Icons.add_circle_outline),
      iconSize: 32,
    );
  }

  Widget _buildAddCartButton() {
    return FilledButton.icon(
      onPressed: () {
        widget.addToCart(_cartNumber);
      },
      icon: const Icon(Icons.add_shopping_cart),
      label: const Text('Add to Booking'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        _buildMinusButton(),
        _buildCartNumberContainer(colorScheme),
        _buildPlusButton(),
        const Spacer(),
        _buildAddCartButton(),
      ],
    );
  }
}
