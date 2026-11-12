-- CareBase Supabase Schema
-- Play Therapy App Builder
-- HIPAA-compliant: PHI stored in user's own Supabase instance

CREATE TABLE clients (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    therapist_id UUID REFERENCES auth.users(id) NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth DATE,
    parent_name TEXT,
    parent_email TEXT,
    parent_phone TEXT,
    diagnosis TEXT,
    referral_source TEXT,
    intake_date DATE DEFAULT CURRENT_DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Therapists can view own clients" ON clients FOR SELECT USING (auth.uid() = therapist_id);
CREATE POLICY "Therapists can insert own clients" ON clients FOR INSERT WITH CHECK (auth.uid() = therapist_id);
CREATE POLICY "Therapists can update own clients" ON clients FOR UPDATE USING (auth.uid() = therapist_id);
CREATE POLICY "Therapists can delete own clients" ON clients FOR DELETE USING (auth.uid() = therapist_id);

CREATE TABLE sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    therapist_id UUID REFERENCES auth.users(id) NOT NULL,
    client_id UUID REFERENCES clients(id) NOT NULL,
    session_date DATE DEFAULT CURRENT_DATE,
    session_duration INTEGER DEFAULT 30,
    toys_used TEXT[] DEFAULT '{}',
    play_behaviors TEXT[] DEFAULT '{}',
    emotional_responses TEXT[] DEFAULT '{}',
    developmental_milestones TEXT[] DEFAULT '{}',
    structured_note TEXT,
    therapist_notes TEXT,
    parent_report TEXT,
    parent_report_sent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Therapists can view own sessions" ON sessions FOR SELECT USING (auth.uid() = therapist_id);
CREATE POLICY "Therapists can insert own sessions" ON sessions FOR INSERT WITH CHECK (auth.uid() = therapist_id);
CREATE POLICY "Therapists can update own sessions" ON sessions FOR UPDATE USING (auth.uid() = therapist_id);
CREATE POLICY "Therapists can delete own sessions" ON sessions FOR DELETE USING (auth.uid() = therapist_id);

CREATE TABLE toys (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    therapist_id UUID REFERENCES auth.users(id) NOT NULL,
    name TEXT NOT NULL,
    category TEXT,
    description TEXT,
    usage_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE toys ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Therapists can manage own toys" ON toys FOR ALL USING (auth.uid() = therapist_id);

CREATE TABLE milestones (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT,
    age_range TEXT,
    description TEXT
);

CREATE INDEX idx_sessions_client ON sessions(client_id);
CREATE INDEX idx_sessions_date ON sessions(session_date);
CREATE INDEX idx_clients_therapist ON clients(therapist_id);
CREATE INDEX idx_toys_therapist ON toys(therapist_id);

INSERT INTO milestones (name, category, age_range, description) VALUES
('Symbolic Play', 'cognitive', '2-4', 'Using one object to represent another'),
('Pretend Play', 'cognitive', '3-5', 'Engaging in imaginative scenarios with roles'),
('Turn-Taking', 'social', '3-5', 'Waiting for their turn in games/activities'),
('Emotional Regulation', 'emotional', '4-6', 'Managing frustration and expressing emotions appropriately'),
('Cooperative Play', 'social', '4-6', 'Playing together with shared goals'),
('Rule-Based Play', 'cognitive', '6-8', 'Following and creating rules in games'),
('Abstract Thinking', 'cognitive', '8-12', 'Understanding complex concepts through play'),
('Self-Expression', 'emotional', '3-12', 'Using play to express inner feelings and thoughts'),
('Problem Solving', 'cognitive', '4-8', 'Working through challenges in play scenarios'),
('Social Skills', 'social', '3-12', 'Initiating and maintaining peer interactions through play');