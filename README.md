# EG-Mobile

تطبيق الموبايل (Flutter) للسيستم الداخلي **EG-System ERP**  
لمصنع **المصرية الألمانية لتصنيع منتجات WPC & PVC** — جمصة، الدقهلية.

Flutter companion app for the plant ERP (`EG-System`).

## Related repos

| Repo | Role |
|------|------|
| [EG-System](https://github.com/Ittihad-group/EG-System) | Web ERP |
| [EG-Website](https://github.com/Ittihad-group/EG-Website) | Public website |
| **EG-Mobile** | Internal mobile ERP app |

## Modules

- Login (demo auth)
- Dashboard KPIs
- Products
- Inventory
- Sales orders
- Production / work orders
- Customers & dealers
- Finance snapshot
- Settings (company + language)

Arabic (RTL) / English.

## Demo login

```
admin@egerman-upvc.com / admin123
sales@egerman-upvc.com / sales123
```

## Run

```bash
flutter pub get
flutter run
```

## Notes

Frontend prototype with local seed data aligned with `EG-System`. Ready to connect to a shared API later.
