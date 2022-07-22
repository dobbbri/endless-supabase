-- public.services definition

-- Drop table

-- DROP TABLE public.services;

CREATE TABLE public.services (
	id int8 NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	user_id uuid NULL,
	created_at timestamptz NULL DEFAULT now(),
	"name" extensions."citext" NULL,
	unit_price numeric NULL DEFAULT '0'::numeric,
	measure_unit varchar NULL,
	code_bar varchar NULL,
	details text NULL,
	image_name varchar NULL,
	CONSTRAINT services_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.services OWNER TO supabase_admin;
GRANT ALL ON TABLE public.services TO postgres;
GRANT ALL ON TABLE public.services TO supabase_admin;
GRANT ALL ON TABLE public.services TO anon;
GRANT ALL ON TABLE public.services TO authenticated;
GRANT ALL ON TABLE public.services TO service_role;


-- public.services foreign keys

ALTER TABLE public.services ADD CONSTRAINT services_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
