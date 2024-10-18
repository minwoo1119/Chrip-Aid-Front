import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/notice_viewmodel.dart';
import 'package:chrip_aid/common/styles/styles.dart';

final noticeViewModelProvider = ChangeNotifierProvider((ref) => NoticeViewModel());

class NoticeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(noticeViewModelProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500), // Limit the width
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Donation Notice",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black, // Main color
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tax Deduction Benefits Section
                        _buildCardSection(
                          title: "Tax Deduction Benefits",
                          content:
                          "- You can receive tax deductions through donation receipts during year-end tax adjustments.\n"
                              "- Donation receipts are issued based on Article 34 of the Income Tax Act and the Restriction of Special Taxation Act.\n"
                              "- Donations can receive tax deductions of 15% up to a maximum of 30% during year-end tax adjustments for salaried workers.\n"
                              "- For specific deduction methods and procedures, please refer to the National Tax Service’s year-end tax adjustment guide.",
                          isChecked: viewModel.isTaxBenefitChecked,
                          onChanged: (value) => viewModel.updateTaxBenefitChecked(value!),
                        ),
                        const SizedBox(height: 16),

                        // Donation Receipt Issuance Section
                        _buildCardSection(
                          title: "Donation Receipt Issuance",
                          content:
                          "- Donation receipts are necessary documents to receive tax deductions during year-end tax adjustments.\n"
                              "- After donating, please send your name, resident registration number, address, and donation details to the orphanage.\n"
                              "- Receipts will be issued within 3-5 days after the request, and will be sent to the email registered during membership sign-up.\n"
                              "- The received donation receipt can be submitted as a deduction item during year-end tax adjustments or income tax filings to receive tax deductions.",
                          isChecked: viewModel.isDonationChecked,
                          onChanged: (value) => viewModel.updateDonationChecked(value!),
                        ),
                        const SizedBox(height: 16),

                        // Personal Information Collection and Consent Section
                        _buildPersonalInfoCardSection(viewModel),

                        const SizedBox(height: 16),

                        // Contact Information Section
                        _buildCardSection(
                          title: "Contact Information",
                          content:
                          "- For inquiries related to donation receipt issuance, please contact the orphanage via the chat feature.",
                          isChecked: viewModel.isContactInfoChecked,
                          onChanged: (value) => viewModel.updateContactInfoChecked(value!),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "I have reviewed all the above items.",
                      style: TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.isAllChecked
                          ? () {
                        Navigator.pop(context); // Close the dialog
                        Navigator.pushNamed(context, '/confirmation'); // Navigate to confirmation page
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.mainColor, // Main color
                      ),
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required String content,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: CustomColor.mainColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: Text("I have reviewed $title."),
              value: isChecked,
              activeColor: CustomColor.mainColor, // Checkbox active color
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCardSection(NoticeViewModel viewModel) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Consent to Collect and Use Personal Information",
              style: TextStyle(
                color: CustomColor.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Collection Items:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- Name, Resident Registration Number, Address, Contact Information, Donation Details"),
            const SizedBox(height: 12),

            Text(
              "Purpose of Use:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "- Issuance of donation receipts\n"
                  "- Legal reporting and donation history management\n"
                  "- Sponsor management\n"
                  "- Customer support and inquiry handling\n"
                  "- Optional marketing and event information provision",
            ),
            const SizedBox(height: 12),

            Text(
              "Retention Period:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- The information will be retained for 5 years after the issuance of the donation receipt, after which it will be destroyed."),
            const SizedBox(height: 12),

            Text(
              "Recipients:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- The National Tax Service and the orphanage issuing the donation receipts."),
            const SizedBox(height: 12),

            Text(
              "Right to Refuse Consent:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("- If you refuse to provide consent, you may not be able to receive a donation receipt."),
            const SizedBox(height: 12),

            Text(
              "Security and Protection:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "- Collected personal information is encrypted and stored securely, and will not be used for purposes other than those approved.",
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: Text("I agree to the collection and use of personal information."),
              value: viewModel.isPersonalInfoChecked,
              activeColor: CustomColor.mainColor, // Checkbox active color
              onChanged: (value) {
                viewModel.updatePersonalInfoChecked(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
