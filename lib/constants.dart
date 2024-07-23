import 'package:flutter/material.dart';

const kWhite = Color(0xFFFFFFFF);

// const kPrimary = Color(0xFF00C2B3);
const kPrimary = Color(0xFF0192ff);
const kSecondary = Color(0xFF00C2B3);

const kPrimaryText = Color(0xFF0F153F);

const kSecondaryText = Color(0xFF9C9FB7);

const kRed = Color(0xFFFC4850);

const textRegular14 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 14,
  color: kPrimaryText,
);

const textRegular16 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 16,
  color: kPrimaryText,
);

const textRegular22 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22,
  color: kPrimaryText,
);

const textRegular32 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 32,
  color: kPrimaryText,
);

const textMedium14 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 14,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);
const textMedium16 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 16,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

const textMedium22 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

const textMedium32 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 32,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

const textBold14 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 14,
  color: kPrimaryText,
  fontWeight: FontWeight.bold,
);
const textBold16 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 16,
  color: kPrimaryText,
  fontWeight: FontWeight.bold,
);

const textBold22 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22,
  color: kPrimaryText,
  fontWeight: FontWeight.bold,
);

const textBold32 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 32,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

ButtonStyle mainButton = ElevatedButton.styleFrom(
  backgroundColor: kPrimary,
  foregroundColor: kWhite,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: BorderSide.none,
  ),
  minimumSize: const Size.fromHeight(56),
);

ButtonStyle secondaryButton = ElevatedButton.styleFrom(
  backgroundColor: Colors.transparent,
  foregroundColor: kPrimary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: const BorderSide(color: kPrimary, width: 2),
  ),
  minimumSize: const Size.fromHeight(56),
);
