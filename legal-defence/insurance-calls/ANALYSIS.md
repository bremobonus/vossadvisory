# Rates Insurance / Aviva contact: what is and isn't illegal

Prepared 2026-11-21 from the emails in the connected Gmail account and the contact log in this folder.
**Not legal advice.** Statute references marked (verify) are from memory and must be checked before you cite them to anyone. A paralegal or a legal clinic can confirm them quickly.

## Bottom line

Most of what Rates and Aviva are doing is **aggressive and ignores your instructions, but is not clearly illegal**. The strongest legal points are not the phone calls themselves. They are:

1. **Refusing to process your cancellation by email.** Rates says "requests for policy cancellations cannot be processed by email" (CL-004). Aviva says it needs a signed form or verbal confirmation because of "internal servicing procedures" (CL-006). The Ontario auto policy and Insurance Act s.234 let the insured end the policy by written notice (verify, and read your own policy wording). A company procedure cannot override the contract or the statute. **This is your best complaint.**
2. **Charging fees on a policy you say you ended** (the $60 reinstatement and $50 NSF). If your Nov 5 written notice was effective, those charges have no basis. This depends on point 1.
3. **Telephoning after you revoked phone consent in writing.** Blanca Muniz Campos admits she phoned you on Nov 20 (CL-001), a day after you said in writing you would take no calls. That is a conduct and privacy complaint, not clearly a crime (see below).

## The calls

| Question | Answer |
|---|---|
| Do the Do Not Call rules apply? | Only if the call is a **sales pitch** (renewal offer, discount, "reinstate and save", a new policy). Calls about an existing policy or a debt are not "telemarketing" under the CRTC rules, and the National DNCL does not cover them. If a call includes a pitch, a written do-not-call request must be honoured (internal list, 14 days, lasts 3 years) even though you are an existing customer. Penalties can reach $15,000 per violation for an individual and $1.5M for a company (verify). **Log whether each call included a pitch.** The log has a field for it. |
| Collection-harassment limits? | Ontario's Collection and Debt Settlement Services Act limits call frequency and conduct, but it is aimed at collection agencies. A creditor collecting its own premium, or a broker acting for it, is a grey area. Not a clean win. |
| Criminal harassment / harassing calls (Criminal Code s.264, s.372(3))? | No. Those need intent to harass or a reasonable fear for safety. One call and three emails in two days will not meet that. Do not threaten criminal charges. It will hurt you. |
| Privacy law (PIPEDA)? | You may withdraw consent for non-essential uses. Contacting you to service a live contract is generally still allowed. Your Nov 9 access request is a separate right: they have 30 days, so **Dec 9, 2026** (verify). |
| Marketing email? | Rates.ca sent "Did someone order a better car insurance rate?" (thread 1a1e5da5d95dee13). If you had withdrawn consent and it arrived later, that is a CASL problem. Check its date against Nov 13. |
| "Your letter looks AI-written" | Rude and dismissive, not illegal. Keep it as evidence of tone. |

## Things that could hurt you (read before you send anything else)

1. **The $859.28 contradiction.** Your Nov 13 notice says $859.28 *was withdrawn* from Scotiabank. Aviva's Nov 20 email says it was *returned NSF* and never applied. Check your bank statement today. If Aviva is right, your notice contains a wrong fact and your refund demand has nothing behind it. Send a short written correction. Your letters say they may be relied on as evidence.
2. **You signed documents.** InsureSign shows a completed signing on **Oct 10, 2026** (thread 1a127d3f27f0a119), probably the application and pre-authorized debit form. "I did not authorize the debit" has to be specific, for example the amount or the Nov 2 change, or it conflicts with your own signature. Download that PDF and read what you signed. I can pull it if you want.
3. **The cancellation sets a trap.** If you refuse the form, Aviva cancels for **non-payment on Dec 21** and says it may be reported in your insurance history (CL-006). With a licence suspension and pending charges, that record will cost you more than the principle gains. Signing their form **under written reservation** ("effective Nov 5, 2026, without prejudice to my position that email was sufficient") gets the same result and keeps your argument.
4. **Do not drive uninsured.** If this policy ends and no other policy covers the car, driving it is an offence under the Compulsory Automobile Insurance Act (verify).
5. **I have not seen the originals** of your Nov 2 change, Nov 5 cancellation, Nov 9 privacy request or Nov 13 letter. I only read your own later descriptions of them. They need to be in the file as primary evidence.

## Where to complain, in order

1. **Aviva**: formal complaint (already cc'd). A final response unlocks step 2.
2. **General Insurance OmbudService (GIO)**: free, handles insurer disputes after a final response.
3. **RIBO** (Registered Insurance Brokers of Ontario): conduct of the brokers, especially refusing the cancellation.
4. **FSRA**: unfair or deceptive practices by the insurer.
5. **Scotiabank**: if any debit was presented outside the PAD terms, a personal PAD claim is open for 90 days from the debit (Payments Canada Rule H1, verify). From Nov 12 that runs to about **Feb 10, 2027**. Also ask the bank to reverse any NSF fee it charged on a debit you dispute.
6. **CRTC** (only if a call included a sales pitch) and the **Spam Reporting Centre** (marketing email after withdrawal).

## How to keep the record strong

- Screenshot your phone's call history for each call (number, time, duration). Add it with `log_call.py add`.
- You may record any call you are part of in Canada (Criminal Code s.184(2)(a), one-party consent). Say "I'm recording" if you want it on the audio.
- Let unknown numbers go to voicemail and save the voicemail. Do not discuss the dispute by phone. Reply in writing.
- Never edit `call-log.jsonl` by hand. The hash chain will flag it. Correct with a new entry.
