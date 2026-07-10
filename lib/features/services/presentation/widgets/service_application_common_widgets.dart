import 'package:flutter/material.dart';

class ServiceApplicationBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const ServiceApplicationBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                size: 18,
                color: Color(0xFF062F5E),
              ),
              SizedBox(width: 8),
              Text(
                'Kembali',
                style: TextStyle(
                  color: Color(0xFF062F5E),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceApplicationSubsectionTitle extends StatelessWidget {
  final String title;

  const ServiceApplicationSubsectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class ServiceApplicationInformationBanner extends StatelessWidget {
  final String? message;
  final InlineSpan? richMessage;

  const ServiceApplicationInformationBanner({
    super.key,
    this.message,
    this.richMessage,
  }) : assert(
  message != null || richMessage != null,
  'message atau richMessage harus diisi',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9FF),
        border: Border.all(
          color: const Color(0xFF3C80FF),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info,
            size: 16,
            color: Color(0xFF216BF3),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              richMessage ?? TextSpan(text: message),
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: Color(0xFF333333),
                height: 1.4,
              ),
            )
          ),
        ],
      ),
    );
  }
}

class ServiceApplicationDocumentValidationCard extends StatelessWidget {
  final String title;
  final String category;
  final String documentNumber;
  final bool isVerified;
  final VoidCallback? onVerifyTap;

  const ServiceApplicationDocumentValidationCard({
    super.key,
    required this.title,
    required this.category,
    required this.documentNumber,
    this.isVerified = true,
    this.onVerifyTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isVerified
        ? const Color(0xFF2C9142)
        : const Color(0xFFE5E5E5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF062F5E),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      documentNumber,
                      style: TextStyle(
                        color: isVerified
                            ? const Color(0xFF333333)
                            : const Color(0xFF999999),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ServiceApplicationStatusBadge(
                isVerified: isVerified,
              ),
            ],
          ),
          if (onVerifyTap != null) ...[
            const SizedBox(height: 14),
            ServiceApplicationVerificationButton(
              label: isVerified ? 'Verifikasi ulang' : 'Verifikasi sekarang',
              onPressed: onVerifyTap,
            ),
          ],
        ],
      ),
    );
  }
}

class ServiceApplicationLabeledTextField extends StatelessWidget {
  final String label;
  final bool requiredField;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? suffixText;
  final Widget? suffixIcon;
  final String? hintText;
  final String? errorText;
  final int maxLines;
  final bool readOnly;
  final bool enabled;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  const ServiceApplicationLabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    this.requiredField = false,
    this.keyboardType,
    this.suffixText,
    this.suffixIcon,
    this.hintText,
    this.errorText,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ServiceApplicationFieldLabel(
          label: label,
          requiredField: requiredField,
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          textInputAction: textInputAction,
          style: const TextStyle(
            color: Color(0xFF444444),
            fontSize: 14,
          ),
          decoration: serviceApplicationFieldDecoration(
            suffixText: suffixText,
            suffixIcon: suffixIcon,
            hintText: hintText,
            errorText: errorText,
            enabled: enabled,
          ),
        ),
      ],
    );
  }
}

class ServiceApplicationDropdownField<T> extends StatelessWidget {
  final String label;
  final bool requiredField;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final bool enabled;

  const ServiceApplicationDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.requiredField = false,
    this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ServiceApplicationFieldLabel(
          label: label,
          requiredField: requiredField,
        ),
        const SizedBox(height: 7),
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          hint: hintText == null
              ? null
              : Text(
            hintText!,
            style: const TextStyle(
              color: Color(0xFFAAAAAA),
              fontSize: 13,
            ),
          ),
          decoration: serviceApplicationFieldDecoration(
            enabled: enabled,
          ),
          items: items,
          onChanged: enabled ? onChanged : null,
          style: const TextStyle(
            color: Color(0xFF444444),
            fontSize: 12,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class ServiceApplicationPersonValidationCard extends StatelessWidget {
  final String name;
  final String familyNumber;
  final String citizenship;

  const ServiceApplicationPersonValidationCard({
    super.key,
    required this.name,
    required this.familyNumber,
    this.citizenship = 'Indonesia',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE6E6E6),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ServiceApplicationSmallInformation(
                  label: 'Nama',
                  value: name,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ServiceApplicationSmallInformation(
                  label: 'No. Kartu Keluarga',
                  value: familyNumber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: _ServiceApplicationSmallInformation(
              label: 'Kewarganegaraan',
              value: citizenship,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceApplicationStatusBadge extends StatelessWidget {
  final bool isVerified;

  const ServiceApplicationStatusBadge({
    super.key,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isVerified
        ? const Color(0xFFE5F7E9)
        : const Color(0xFFFCECEC);

    final foregroundColor = isVerified
        ? const Color(0xFF25843A)
        : const Color(0xFFE33B3B);

    final icon = isVerified
        ? Icons.check_circle
        : Icons.error;

    final label = isVerified
        ? 'Terverifikasi'
        : 'Belum terverifikasi';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: foregroundColor,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceApplicationVerificationButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const ServiceApplicationVerificationButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF062F5E),
          side: const BorderSide(
            color: Color(0xFFE0E0E0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        icon: Icon(
          label.toLowerCase().contains('ulang')
              ? Icons.sync
              : Icons.camera_alt_outlined,
          size: 17,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class ServiceApplicationPersonVerificationSection extends StatelessWidget {
  final String title;
  final bool isVerified;
  final String name;
  final String job;
  final VoidCallback onVerifyTap;

  const ServiceApplicationPersonVerificationSection({
    super.key,
    required this.title,
    required this.isVerified,
    required this.name,
    required this.job,
    required this.onVerifyTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isVerified
        ? const Color(0xFF2C9142)
        : const Color(0xFFE5E5E5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ServiceApplicationStatusBadge(
              isVerified: isVerified,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ServiceApplicationInformationLine(
                label: 'Nama',
                value: name,
                isEmpty: !isVerified,
              ),
              const SizedBox(height: 14),
              _ServiceApplicationInformationLine(
                label: 'Pekerjaan',
                value: job,
                isEmpty: !isVerified,
              ),
              const SizedBox(height: 16),
              ServiceApplicationVerificationButton(
                label: isVerified ? 'Verifikasi ulang' : 'Verifikasi sekarang',
                onPressed: onVerifyTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ServiceApplicationInformationLine extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmpty;

  const _ServiceApplicationInformationLine({
    required this.label,
    required this.value,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isEmpty ? 'Belum tersedia' : value,
          style: TextStyle(
            color: isEmpty
                ? const Color(0xFFAAAAAA)
                : const Color(0xFF062F5E),
            fontSize: 14,
            fontWeight: isEmpty ? FontWeight.w400 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class ServiceApplicationQrDialog extends StatelessWidget {
  const ServiceApplicationQrDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 420,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scan QR',
                            style: TextStyle(
                              color: Color(0xFF252525),
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Arahkan kode QR pada aplikasi IKD ke kamera.',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 14,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 26,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C80E8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF062F5E)
                              .withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.info,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Pastikan QR terlihat jelas.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.qr_code_2,
                            size: 190,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE5E5E5),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF062F5E),
                      side: const BorderSide(
                        color: Color(0xFFE0E0E0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: const Text(
                      'Tutup',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceApplicationTermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ServiceApplicationTermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            activeColor: const Color(0xFF062F5E),
            onChanged: (checked) {
              onChanged(checked ?? false);
            },
          ),
          const SizedBox(width: 6),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Saya menyetujui dengan semua ',
                    ),
                    TextSpan(
                      text: 'Syarat dan Ketentuan',
                      style: TextStyle(
                        color: Color(0xFF062F5E),
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF062F5E),
                        decorationThickness: 1.4,
                      ),
                    ),
                    TextSpan(
                      text: ' dari INAKU.',
                    ),
                  ],
                ),
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12.5,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceApplicationSummaryData {
  final String label;
  final String value;
  final bool isSectionTitle;

  const ServiceApplicationSummaryData({
    required this.label,
    required this.value,
    this.isSectionTitle = false,
  });
}

class ServiceApplicationSummaryGroup extends StatelessWidget {
  final String title;
  final List<ServiceApplicationSummaryData> rows;

  const ServiceApplicationSummaryGroup({
    super.key,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    final visibleRows = rows.where((row) {
      return row.isSectionTitle || row.label.trim().isNotEmpty;
    }).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF252525),
              fontSize: 16,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          for (int index = 0; index < visibleRows.length; index++) ...[
            if (visibleRows[index].isSectionTitle)
              Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 0 : 6,
                  bottom: 12,
                ),
                child: Text(
                  visibleRows[index].label,
                  style: const TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                  ),
                ),
              )
            else ...[
              _ServiceApplicationSummaryRow(
                data: visibleRows[index],
              ),
              if (index != visibleRows.length - 1 &&
                  !visibleRows[index + 1].isSectionTitle)
                const Divider(
                  height: 22,
                  thickness: 0.7,
                  color: Color(0xFFE5E5E5),
                )
              else
                const SizedBox(height: 12),
            ],
          ],
        ],
      ),
    );
  }
}

class _ServiceApplicationSummaryRow extends StatelessWidget {
  final ServiceApplicationSummaryData data;

  const _ServiceApplicationSummaryRow({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.label,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          data.value.trim().isNotEmpty ? data.value : '-',
          style: const TextStyle(
            color: Color(0xFF252525),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class ServiceApplicationActions extends StatelessWidget {
  final String? primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final String? cancelLabel;
  final VoidCallback? onCancelPressed;

  const ServiceApplicationActions({
    super.key,
    this.primaryLabel = 'Selanjutnya',
    this.onPrimaryPressed,
    this.secondaryLabel = 'Sebelumnya',
    this.onSecondaryPressed,
    this.cancelLabel = 'Batal',
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];

    if (primaryLabel != null) {
      buttons.add(
        _ServiceApplicationPrimaryButton(
          label: primaryLabel!,
          onPressed: onPrimaryPressed,
        ),
      );
    }

    if (secondaryLabel != null) {
      buttons.add(
        _ServiceApplicationSecondaryButton(
          label: secondaryLabel!,
          onPressed: onSecondaryPressed,
        ),
      );
    }

    if (cancelLabel != null) {
      buttons.add(
        _ServiceApplicationSecondaryButton(
          label: cancelLabel!,
          onPressed: onCancelPressed,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int index = 0; index < buttons.length; index++) ...[
          if (index > 0) const SizedBox(height: 9),
          buttons[index],
        ],
      ],
    );
  }
}

class ServiceApplicationSuccessView extends StatelessWidget {
  final String title;
  final String description;
  final String statusButtonLabel;
  final String returnButtonLabel;
  final VoidCallback onStatusPressed;
  final VoidCallback onReturnPressed;

  const ServiceApplicationSuccessView({
    super.key,
    required this.title,
    required this.description,
    required this.onStatusPressed,
    required this.onReturnPressed,
    this.statusButtonLabel = 'Lihat status',
    this.returnButtonLabel = 'Kembali ke Layanan',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6),
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF27883B),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 15,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: _ServiceApplicationSecondaryButton(
            label: statusButtonLabel,
            onPressed: onStatusPressed,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: onReturnPressed,
          child: Text(
            returnButtonLabel,
            style: const TextStyle(
              color: Color(0xFF062F5E),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

Future<bool?> showServiceApplicationConfirmationDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  String confirmLabel = 'Ya',
  String cancelLabel = 'Tidak',
  bool barrierDismissible = false,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 420,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              16,
              18,
              18,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop(false);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                content,
                const SizedBox(height: 18),
                ServiceApplicationActions(
                  primaryLabel: confirmLabel,
                  onPrimaryPressed: () {
                    Navigator.of(dialogContext).pop(true);
                  },
                  secondaryLabel: cancelLabel,
                  onSecondaryPressed: () {
                    Navigator.of(dialogContext).pop(false);
                  },
                  cancelLabel: null,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

InputDecoration serviceApplicationFieldDecoration({
  String? suffixText,
  Widget? suffixIcon,
  String? hintText,
  String? errorText,
  bool enabled = true,
}) {
  return InputDecoration(
    isDense: true,
    suffixText: suffixText,
    suffixIcon: suffixIcon,
    hintText: hintText,
    errorText: errorText,
    filled: !enabled,
    fillColor: enabled
        ? Colors.white
        : const Color(0xFFF5F5F5),
    hintStyle: const TextStyle(
      color: Color(0xFFAAAAAA),
      fontSize: 13,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 13,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE0E3E7),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE5E5E5),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFF216BF3),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE33B3B),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE33B3B),
      ),
    ),
  );
}

class _ServiceApplicationFieldLabel extends StatelessWidget {
  final String label;
  final bool requiredField;

  const _ServiceApplicationFieldLabel({
    required this.label,
    required this.requiredField,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: label),
          if (requiredField)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Color(0xFFE33B3B),
              ),
            ),
        ],
      ),
    );
  }
}

class _ServiceApplicationSmallInformation extends StatelessWidget {
  final String label;
  final String value;

  const _ServiceApplicationSmallInformation({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ServiceApplicationPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _ServiceApplicationPrimaryButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF062F5E),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFECECEC),
          disabledForegroundColor: const Color(0xFFAAAAAA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ServiceApplicationSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _ServiceApplicationSecondaryButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF333333),
          disabledForegroundColor: const Color(0xFFAAAAAA),
          backgroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFF4F4F4),
          side: const BorderSide(
            color: Color(0xFFE0E0E0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
