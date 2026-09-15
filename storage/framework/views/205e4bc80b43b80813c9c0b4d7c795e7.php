<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mallow Billing — Merchant Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --brand:#6366f1; --brand-light:#818cf8;
            --ink:#1e1b4b; --ink2:#334155; --muted:#94a3b8; --line:#e2e8f0;
            --bg:#f1f5f9; --card:#fff;
            --emerald:#059669; --emerald-bg:#d1fae5; --emerald-grad:linear-gradient(135deg,#059669,#10b981);
            --violet:#7c3aed; --violet-bg:#ede9fe; --violet-grad:linear-gradient(135deg,#7c3aed,#a78bfa);
            --amber:#d97706; --amber-bg:#fef3c7; --amber-grad:linear-gradient(135deg,#d97706,#fbbf24);
            --rose:#e11d48; --rose-bg:#ffe4e6; --rose-grad:linear-gradient(135deg,#e11d48,#fb7185);
            --sky:#0284c7; --sky-bg:#e0f2fe; --sky-grad:linear-gradient(135deg,#0284c7,#38bdf8);
            --danger:#dc2626; --ok:#059669;
        }
        * { box-sizing:border-box; margin:0; padding:0; }
        body { font-family:'Inter', system-ui, -apple-system, sans-serif; background:var(--bg); color:var(--ink); min-height:100vh; }
        .wrap { max-width:1120px; margin:0 auto; padding:0 20px 60px; }

        /* ── header bar ─────────────────────────────────────────────── */
        .hero { background:linear-gradient(135deg,#6366f1 0%,#8b5cf6 40%,#a78bfa 100%); padding:32px 0 28px; margin-bottom:32px; color:#fff; }
        .hero-inner { max-width:1120px; margin:0 auto; padding:0 20px; display:flex; align-items:center; justify-content:space-between; gap:16px; flex-wrap:wrap; }
        .hero h1 { font-size:26px; font-weight:800; letter-spacing:-.02em; }
        .hero .sub { color:rgba(255,255,255,.75); font-size:13px; margin-top:4px; }
        .hero select {
            padding:9px 14px; border:1px solid rgba(255,255,255,.3); border-radius:10px;
            background:rgba(255,255,255,.15); backdrop-filter:blur(4px); color:#fff; font-size:14px; font-family:inherit;
            cursor:pointer; appearance:none; -webkit-appearance:none;
            background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='white' stroke-width='1.5' fill='none'/%3E%3C/svg%3E");
            background-repeat:no-repeat; background-position:right 12px center; padding-right:32px;
        }
        .hero select option { color:#333; background:#fff; }

        /* ── KPI cards ──────────────────────────────────────────────── */
        .cards { display:grid; grid-template-columns:repeat(3,1fr); gap:18px; margin-bottom:28px; }
        .card {
            background:var(--card); border-radius:16px; padding:0; overflow:hidden;
            box-shadow:0 1px 3px rgba(0,0,0,.06), 0 4px 14px rgba(0,0,0,.04);
            transition:transform .15s, box-shadow .15s;
        }
        .card:hover { transform:translateY(-2px); box-shadow:0 4px 16px rgba(0,0,0,.1); }
        .card-bar { height:4px; }
        .card-body { padding:18px 20px 16px; }
        .card .icon { display:inline-flex; width:36px; height:36px; border-radius:10px; align-items:center; justify-content:center; font-size:18px; margin-bottom:10px; }
        .card .label { font-size:12px; text-transform:uppercase; letter-spacing:.06em; color:var(--muted); font-weight:600; margin-bottom:6px; }
        .card .value { font-size:28px; font-weight:800; letter-spacing:-.02em; }
        .card .hint { font-size:12px; color:var(--muted); margin-top:4px; font-weight:500; }

        .card.usage .card-bar { background:var(--sky-grad); }
        .card.usage .icon { background:var(--sky-bg); color:var(--sky); }
        .card.usage .value { color:var(--sky); }

        .card.revenue .card-bar { background:var(--emerald-grad); }
        .card.revenue .icon { background:var(--emerald-bg); color:var(--emerald); }
        .card.revenue .value { color:var(--emerald); }

        .card.churn .card-bar { background:var(--rose-grad); }
        .card.churn .icon { background:var(--rose-bg); color:var(--rose); }
        .card.churn .value { color:var(--rose); }

        /* ── sections ───────────────────────────────────────────────── */
        section {
            background:var(--card); border-radius:16px; padding:0; overflow:hidden;
            margin-bottom:20px; box-shadow:0 1px 3px rgba(0,0,0,.06), 0 4px 14px rgba(0,0,0,.04);
        }
        .sec-header { padding:20px 24px 14px; display:flex; align-items:center; gap:10px; }
        .sec-header .dot { width:10px; height:10px; border-radius:50%; flex-shrink:0; }
        section h2 { font-size:16px; font-weight:700; }
        section .empty-msg { padding:0 24px 24px; color:var(--muted); font-size:14px; }

        /* ── tables ─────────────────────────────────────────────────── */
        table { width:100%; border-collapse:collapse; }
        th, td { text-align:left; padding:12px 20px; font-size:14px; }
        tr:not(:last-child) td { border-bottom:1px solid var(--line); }
        tr:last-child td { border-bottom:none; }
        th { color:var(--muted); font-weight:600; font-size:11px; text-transform:uppercase; letter-spacing:.06em; background:#f8fafc; }
        tbody tr { transition:background .12s; }
        tbody tr:hover { background:#f8fafc; }

        /* ── rank badges ────────────────────────────────────────────── */
        .rank {
            display:inline-flex; width:26px; height:26px; align-items:center; justify-content:center;
            border-radius:8px; font-weight:700; font-size:12px;
        }
        .rank.gold   { background:linear-gradient(135deg,#fbbf24,#f59e0b); color:#78350f; }
        .rank.silver { background:linear-gradient(135deg,#cbd5e1,#94a3b8); color:#334155; }
        .rank.bronze { background:linear-gradient(135deg,#fdba74,#f97316); color:#7c2d12; }
        .rank.normal { background:#e2e8f0; color:#475569; }

        .email { color:var(--muted); font-size:13px; }

        /* ── pills ──────────────────────────────────────────────────── */
        .pill {
            display:inline-flex; align-items:center; gap:4px; padding:3px 12px; border-radius:999px;
            font-size:12px; font-weight:700; letter-spacing:.02em;
        }
        .pill.bad  { background:var(--rose-bg); color:var(--rose); }
        .pill.good { background:var(--emerald-bg); color:var(--emerald); }

        /* ── drop bar ───────────────────────────────────────────────── */
        .drop-bar { display:flex; align-items:center; gap:8px; margin-top:2px; }
        .drop-bar .track { flex:1; height:6px; background:#fee2e2; border-radius:3px; overflow:hidden; }
        .drop-bar .fill  { height:100%; background:var(--rose-grad); border-radius:3px; }
        .drop-bar .pct   { font-size:11px; font-weight:700; color:var(--rose); min-width:36px; }

        /* ── footer ─────────────────────────────────────────────────── */
        footer { color:var(--muted); font-size:12px; text-align:center; margin-top:32px; }
        a.muted { color:var(--brand); text-decoration:none; font-weight:500; }
        a.muted:hover { text-decoration:underline; }

        .empty { text-align:center; padding:100px 20px; color:var(--muted); }
        .empty .big { font-size:48px; margin-bottom:16px; }
        .empty h2 { font-size:20px; font-weight:700; color:var(--ink); margin-bottom:8px; }
        .empty code { background:#e2e8f0; padding:2px 8px; border-radius:6px; font-size:13px; }

        @media (max-width:700px) {
            .cards { grid-template-columns:1fr; }
            .hero-inner { flex-direction:column; align-items:flex-start; }
        }
    </style>
</head>
<body>

<?php if(! empty($empty)): ?>
<div class="wrap">
    <div class="empty">
        <div class="big">&#127978;</div>
        <h2>No merchants yet</h2>
        <p>Run <code>php artisan migrate --seed</code> to create a demo merchant and customers.</p>
    </div>
</div>
<?php else: ?>
<div class="hero">
    <div class="hero-inner">
        <div>
            <h1>Merchant Dashboard</h1>
            <div class="sub"><?php echo e($metrics['merchant']['name']); ?> &middot; <?php echo e($metrics['cycle_start']); ?> &rarr; <?php echo e($metrics['cycle_end']); ?></div>
        </div>
        <form method="get">
            <select name="merchant" onchange="this.form.submit()">
                <?php $__currentLoopData = $merchants; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $m): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                    <option value="<?php echo e($m->id); ?>" <?php if($m->id === $merchant->id): echo 'selected'; endif; ?>><?php echo e($m->name); ?> (#<?php echo e($m->id); ?>)</option>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
            </select>
        </form>
    </div>
</div>

<div class="wrap">

        <?php
            $top = $metrics['top_5_customers_by_usage_this_month'];
            $topName = $top->isNotEmpty() ? $top->first()->name : null;
            $topUnits = $top->isNotEmpty() ? $top->first()->total_units : 0;
            $overage = $metrics['projected_overage_revenue_current_cycle'];
            $churnCount = count($metrics['usage_drop_over_50_percent_month_over_month']);
            $rankClasses = ['gold','silver','bronze','normal','normal'];
        ?>

        
        <div class="cards">
            <div class="card usage">
                <div class="card-bar"></div>
                <div class="card-body">
                    <div class="icon">&#9889;</div>
                    <div class="label">Top Customer Usage (MTD)</div>
                    <div class="value"><?php echo e($topUnits ? number_format($topUnits) : '0'); ?> <span style="font-size:14px;font-weight:500;opacity:.7">units</span></div>
                    <div class="hint"><?php echo e($topName ?? 'No usage aggregated'); ?></div>
                </div>
            </div>
            <div class="card revenue">
                <div class="card-bar"></div>
                <div class="card-body">
                    <div class="icon">&#128176;</div>
                    <div class="label">Projected Overage Revenue</div>
                    <div class="value">&#8377;<?php echo e(number_format($overage, 2)); ?></div>
                    <div class="hint">Current billing cycle</div>
                </div>
            </div>
            <div class="card churn">
                <div class="card-bar"></div>
                <div class="card-body">
                    <div class="icon">&#9888;&#65039;</div>
                    <div class="label">Churn-Risk Customers</div>
                    <div class="value"><?php echo e($churnCount); ?></div>
                    <div class="hint">&gt;50% usage drop MoM</div>
                </div>
            </div>
        </div>

        
        <section>
            <div class="sec-header">
                <div class="dot" style="background:var(--sky-grad)"></div>
                <h2>Top 5 Customers by Usage &mdash; This Month</h2>
            </div>
            <?php if($top->isEmpty()): ?>
                <div class="empty-msg">No aggregated usage yet. Send a <code>POST /api/usage</code> event, then run the aggregation job.</div>
            <?php else: ?>
                <table>
                    <thead>
                        <tr><th style="width:50px">#</th><th>Customer</th><th style="width:160px;text-align:right">Usage (units)</th></tr>
                    </thead>
                    <tbody>
                        <?php $__currentLoopData = $top; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $i => $customer): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                                <td><span class="rank <?php echo e($rankClasses[$i] ?? 'normal'); ?>"><?php echo e($i + 1); ?></span></td>
                                <td><?php echo e($customer->name); ?> <span class="email">&middot; <?php echo e($customer->email); ?></span></td>
                                <td style="text-align:right;font-weight:700"><?php echo e(number_format($customer->total_units)); ?></td>
                            </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </section>

        
        <section>
            <div class="sec-header">
                <div class="dot" style="background:var(--rose-grad)"></div>
                <h2>Churn-Risk Customers (&gt;50% usage drop MoM)</h2>
            </div>
            <?php $risks = $metrics['usage_drop_over_50_percent_month_over_month']; ?>
            <?php if(empty($risks)): ?>
                <div class="empty-msg">No customers flagged. Run a few days of usage in different months to see MoM comparisons.</div>
            <?php else: ?>
                <table>
                    <thead>
                        <tr><th>Customer</th><th style="width:140px;text-align:right">Last Month</th><th style="width:140px;text-align:right">This Month</th><th style="width:200px">Drop</th><th style="width:120px">Status</th></tr>
                    </thead>
                    <tbody>
                        <?php $__currentLoopData = $risks; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $risk): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <?php
                                $old = $risk['last_month_units'];
                                $new = $risk['this_month_units'];
                                $pct = $old > 0 ? round((1 - $new / $old) * 100) : 0;
                            ?>
                            <tr>
                                <td><?php echo e($risk['customer']->name); ?> <span class="email">&middot; <?php echo e($risk['customer']->email); ?></span></td>
                                <td style="text-align:right"><?php echo e(number_format($old)); ?></td>
                                <td style="text-align:right"><?php echo e(number_format($new)); ?></td>
                                <td>
                                    <div class="drop-bar">
                                        <div class="track"><div class="fill" style="width:<?php echo e($pct); ?>%"></div></div>
                                        <div class="pct">&minus;<?php echo e($pct); ?>%</div>
                                    </div>
                                </td>
                                <td><span class="pill bad">&#9888; Churn risk</span></td>
                            </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </section>

        <footer>
            API: <a class="muted" href="/api/merchants/<?php echo e($merchant->id); ?>/dashboard">GET /api/merchants/<?php echo e($merchant->id); ?>/dashboard</a> &middot;
            <a class="muted" href="/api/usage">POST /api/usage</a>
        </footer>

    <?php endif; ?>

</div>
</body>
</html><?php /**PATH C:\xampp\htdocs\mallow-billing\resources\views/dashboard.blade.php ENDPATH**/ ?>