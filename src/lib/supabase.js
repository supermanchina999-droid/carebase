// supabase.js
// CareBase Supabase Client
// HIPAA-compliant: uses user's own Supabase instance

import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || '';
const supabaseAnonKey = process.env.REACT_APP_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
  }
});

export async function getCurrentTherapist() {
  const { data: { user } } = await supabase.auth.getUser();
  return user;
}

export async function signUpTherapist(email, password) {
  const { data, error } = await supabase.auth.signUp({
    email, password,
    options: { data: { role: 'therapist' } }
  });
  return { data, error };
}

export async function signInTherapist(email, password) {
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  return { data, error };
}

export async function saveSessionNote(sessionData) {
  const { data, error } = await supabase.from('sessions').insert(sessionData).select();
  return { data, error };
}

export async function getClientSessions(clientId) {
  const { data, error } = await supabase.from('sessions').select('*').eq('client_id', clientId).order('session_date', { ascending: false });
  return { data, error };
}

export async function getTherapistClients(therapistId) {
  const { data, error } = await supabase.from('clients').select('*').eq('therapist_id', therapistId).order('last_name', { ascending: true });
  return { data, error };
}