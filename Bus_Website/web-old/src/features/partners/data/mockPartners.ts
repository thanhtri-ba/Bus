export interface Partner {
  id: string;
  name: string;
  logo: string;
  rating: string;
  reviews: string;
  tags: string[];
  routes: string[];
}

export const mockPartners: Partner[] = [
  {
    id: "1",
    name: "Orion Premium Express",
    logo: "https://lh3.googleusercontent.com/aida-public/AB6AXuBcD90SIXhyijFy45bocnNsy34TasiMhzdxiKKEY8NzzmzL6ohw-_eXzxMaEzIBL3MVscc3Ccbh7kPwXG6ChoVRSeb6ICgCwgINLkzBIg2aI9oB__WRUAtP73HLwXLsanShDg0wcCCQgaAEAICjmh2I6cSG_rxz1jfRvTi70m1MA-uEK_CRiyYqp2dLb4_E8s15tHqH6h4JasOi1f8UzJRmhPKm-DZPyWcUlrsNc64OHx2XdbY1heATiA",
    rating: "4.9",
    reviews: "2.4k",
    tags: ["Luxury", "Sleeper"],
    routes: ["London to Edinburgh", "Paris to Amsterdam"]
  },
  {
    id: "2",
    name: "SwiftLink Transit",
    logo: "https://lh3.googleusercontent.com/aida-public/AB6AXuBSryG7R-_aFxkSas_uSQl7KXf7iwR5b29Wfb_0ntN-WjYoM037vJkuk-1oQCK7NToMzMyIZ7_DfWc3La_Fc3z4S8JfqeRIRzv2fDQxOgvEmKneOoeIhWEYBygNVx_Jx3K7xL2WQAcVbm13GTQqv4GcvKuv7InhrBBh_-f8wRt5MXt258wpP-4F3XyD2-Worp4O4JxHFxvnmvIuN3bJvD4KI7KQOeW3wzMJnHvGaV_isE4nbo_L7ffzBQ",
    rating: "4.7",
    reviews: "1.8k",
    tags: ["Limousine"],
    routes: ["Berlin to Prague", "Vienna to Munich"]
  },
  {
    id: "3",
    name: "SilverLine Coaches",
    logo: "https://lh3.googleusercontent.com/aida-public/AB6AXuCtJP-lR6SibkR7SZrNnJCDU__x1Bd-CUL_WdyTD-D_oNQwDdoR91rjtua_eiUPJFcNs8Ir_AfVD5PWTpRPMm_x3XFPLz73GCWWAhc1N1QsJLxUCmWvs-9_Da-6yghdVwOJEa8ZzvYTXRy4qRB4qh4tr2LwNsm4ZD7nIS4v4kSCr_u2wMNNaCgC6KEP6AivZ_jGmje9g_WwQLT7kKG5HF3q5C5OHpZrjoIq7MOA2zzIDC18ox-B6BMPnQ",
    rating: "4.5",
    reviews: "3.1k",
    tags: ["Luxury", "Executive"],
    routes: ["Madrid to Barcelona", "Lisbon to Seville"]
  },
  {
    id: "4",
    name: "Cloud9 Sleepers",
    logo: "https://lh3.googleusercontent.com/aida-public/AB6AXuDdyaosa5nvTKAtaUzHSBDbE1xjYaMhoLcixhLXWOJPM6dKo21Fs3xKJD2rn7ZVrqpkhi6cYW12-5qS28qom3HPxSj1cuobC6Qx3SeBByjxKC9zb38Vr898R73IufNpQVjIYeAAPfq50j7vWRzlbDkb9qmhE-Eq2yOw_8kMJ7T9g7T-FvM0KLCJ6YmW9A601IbSOhL2du8sfCnVFXZmFg3bSYifgOpbXLJEDt30TNlJ9nxzIBzKN2OoLw",
    rating: "4.8",
    reviews: "950",
    tags: ["Sleeper", "VIP"],
    routes: ["Milan to Rome", "Naples to Florence"]
  },
  {
    id: "5",
    name: "TransEuro Interlink",
    logo: "https://lh3.googleusercontent.com/aida-public/AB6AXuDc_e6kEl3kGtC3kAHo_PFDQTBC63zLwg5zx8fREYJzJoGyEIENbQITrQDmvgwPTSFxcdFNcFjmkr5rlZ-2RFq7xFSAUHX1ZxJuXpsy9wf68r69YAocBsw6cgbi6Scz72_fKt-OuTktVSmT5kPdGzFYPOL2YekJcVLUMrorItiXBH031IpGEPbf3DGUkWc_U-U8mz-VZf1bKE0G5PcCQ8PB5JsQvATZQty0Ip2OB_0yMQTuDj_nz0VdrA",
    rating: "4.6",
    reviews: "4.2k",
    tags: ["Standard", "Executive"],
    routes: ["Paris to Lyon", "Brussels to Luxembourg"]
  },
  {
    id: "6",
    name: "Velvet Road Limousines",
    logo: "https://lh3.googleusercontent.com/aida-public/AB6AXuDe5nJt7SkJwpczP4YjfluB9vVxFHn4bKV94zPO7FE4JLXhpaQt7PyXnYi_39S6gR-10d--Uc_w6tiK-5LJjXmZZbJG-ikkBOdFC_ytOqfcsvCDcf0E4renNT2cUdwNq_WJTTVxbVcJ9red_kfAppED4X9ai1l1qTq0mi6u8raa5luk3KblQrlqXILjiqsrSnBIPorNoWqVTXIpBjBFQqLuuCKYUio4WybxqkFy0wzQ35GeSuMDPlo1XA",
    rating: "5.0",
    reviews: "520",
    tags: ["Limousine", "Luxury"],
    routes: ["Zurich to Geneva", "London to Brighton"]
  }
];
