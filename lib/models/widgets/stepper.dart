import 'package:flutter/material.dart';

class DeliveryStep {
  final String title;
  final String description;
  DeliveryStep({required this.title, required this.description});
}

class DeliveryTrackingPage extends StatefulWidget {
  final List<DeliveryStep> steps = [
    DeliveryStep(
      title: 'Order Placed',
      description: 'Your order has been placed successfully.',
    ),
    DeliveryStep(
      title: 'Processing',
      description: 'Your order is being processed.',
    ),
    DeliveryStep(
      title: 'Shipped',
      description: 'Your order has been shipped.',
    ),
    DeliveryStep(
      title: 'Out for Delivery',
      description: 'Your order is out for delivery.',
    ),
    DeliveryStep(
      title: 'Delivered',
      description: 'Your order has been delivered. Thank you!',
    ),
  ];

  DeliveryTrackingPage({super.key});

  @override
  State<DeliveryTrackingPage> createState() => _DeliveryTrackingPageState();
}

class _DeliveryTrackingPageState extends State<DeliveryTrackingPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < widget.steps.length - 1) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: widget.steps
            .map(
              (step) => Step(
            title: Text(step.title),
            content: Text(step.description),
            isActive: _currentStep == widget.steps.indexOf(step),
            state: _currentStep > widget.steps.indexOf(step)
                ? StepState.complete
                : StepState.disabled,
          ),
        )
            .toList(),
      ),
    );
  }
}