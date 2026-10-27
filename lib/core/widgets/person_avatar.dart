import 'package:flutter/material.dart';

import '../../features/people/domain/person.dart';
import '../theme/color_schemes.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar(this.person, {super.key, this.size = 32});

  final Person person;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = colorFromHex(person.colorHex);
    return Tooltip(
      message: person.name,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.lerp(color, Colors.white, 0.25)!, color],
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: size > 28 ? 2 : 1.5,
          ),
        ),
        child: Text(
          person.initials,
          style: TextStyle(
            color: onColor(color),
            fontWeight: FontWeight.w700,
            fontSize: size * 0.38,
          ),
        ),
      ),
    );
  }
}

/// Üst üste binen avatarlar.
class AvatarStack extends StatelessWidget {
  const AvatarStack(this.people, {super.key, this.size = 28, this.max = 4});

  final List<Person> people;
  final double size;
  final int max;

  @override
  Widget build(BuildContext context) {
    if (people.isEmpty) return const SizedBox.shrink();
    final shown = people.take(max).toList();
    final extra = people.length - shown.length;
    final step = size * 0.68;
    final count = shown.length + (extra > 0 ? 1 : 0);
    return SizedBox(
      height: size,
      width: step * (count - 1) + size,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * step,
              child: PersonAvatar(shown[i], size: size),
            ),
          if (extra > 0)
            Positioned(
              left: shown.length * step,
              child: CircleAvatar(
                radius: size / 2,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                child: Text('+$extra', style: TextStyle(fontSize: size * 0.36)),
              ),
            ),
        ],
      ),
    );
  }
}
